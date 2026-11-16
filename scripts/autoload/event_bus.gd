extends Node

## Signals shared across otherwise independent game systems.
## Keep this as a message channel; do not store authoritative gameplay state here.

signal session_started(mode_id: String)
signal session_ended(mode_id: String, results: Dictionary)
signal player_health_changed(player_id: String, current: float, maximum: float)
signal player_score_changed(player_id: String, score: int)
signal currency_changed(player_id: String, amount: int)
signal peer_connection_changed(peer_id: int, connected: bool)
