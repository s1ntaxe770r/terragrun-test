"""Bandwidth-limited HTTP CONNECT proxy, used when tc shaping is unavailable on a runner.

usage: throttle_proxy.py <port> <bytes_per_second_server_to_client>
Point git at it with: git config --global http.proxy http://127.0.0.1:<port>
Only the server->client direction (what a clone downloads) is limited.
"""
import asyncio
import sys

PORT = int(sys.argv[1])
RATE = int(sys.argv[2])


async def pipe(reader, writer, rate=0):
    chunk_size = 65536 if rate == 0 else max(1024, rate // 10)
    try:
        while True:
            chunk = await reader.read(chunk_size)
            if not chunk:
                break
            if rate:
                await asyncio.sleep(len(chunk) / rate)
            writer.write(chunk)
            await writer.drain()
    except Exception:
        pass
    finally:
        try:
            writer.close()
        except Exception:
            pass


async def handle(client_r, client_w):
    request = (await client_r.readline()).decode(errors="replace").split()
    while (await client_r.readline()) not in (b"\r\n", b""):
        pass
    if len(request) < 2 or request[0] != "CONNECT":
        client_w.write(b"HTTP/1.1 405 Method Not Allowed\r\n\r\n")
        await client_w.drain()
        client_w.close()
        return
    host, port = request[1].rsplit(":", 1)
    try:
        remote_r, remote_w = await asyncio.open_connection(host, int(port))
    except Exception:
        client_w.write(b"HTTP/1.1 502 Bad Gateway\r\n\r\n")
        await client_w.drain()
        client_w.close()
        return
    client_w.write(b"HTTP/1.1 200 Connection established\r\n\r\n")
    await client_w.drain()
    await asyncio.gather(pipe(client_r, remote_w), pipe(remote_r, client_w, RATE))


async def main():
    server = await asyncio.start_server(handle, "127.0.0.1", PORT)
    async with server:
        await server.serve_forever()


asyncio.run(main())
