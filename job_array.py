import os
import sys
import time

# Get task ID from Slurm environment variable
task_id = int(os.getenv("SLURM_ARRAY_TASK_ID", 0))

# Optional: Define a list of tasks or parameters
items = ["alpha", "beta", "gamma", "delta", "epsilon"]

# Guard: ensure task_id is within range
if task_id < len(items):
    item = items[task_id]
    print(f"[Task {task_id}] Processing item: {item}")
    time.sleep(600)  # Simulate work
    print(f"[Task {task_id}] Done.")
else:
    print(f"[Task {task_id}] No task defined for this index.")