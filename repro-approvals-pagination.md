# Repro: digger approvals=[] when PR has >30 reviews

This PR receives 31 COMMENTED reviews (simulating a per-file review bot),
then one real APPROVED review.

Digger GetApprovals (libs/ci/github/github.go:248) calls ListReviews once
with empty ListOptions{} -> GitHub default per_page=30, no pagination loop.
The approval lands on page 2 and is never fetched: approvals=[], approval_teams=[].
