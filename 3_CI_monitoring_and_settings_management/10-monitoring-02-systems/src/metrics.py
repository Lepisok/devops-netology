import os
import time
import json

# Get the current timestamp
timestamp = time.strftime("%a, %d %b %Y %H:%M:%S")

# CPU usage metrics
with open('/proc/stat') as f:
    for line in f:
        if line.startswith('cpu '):
            fields = line.split()
            user, nice, system, idle = int(fields[1]), int(fields[2]), int(fields[3]), int(fields[4])
            break
total = user + nice + system + idle
cpu_usage = 100 * (total - idle) / total

# Memory usage metrics
with open('/proc/meminfo') as f:
    for line in f:
        if line.startswith('MemTotal:'):
            total_mem = int(line.split()[1])
        elif line.startswith('MemFree:'):
            free_mem = int(line.split()[1])
mem_usage = 100 * (total_mem - free_mem) / total_mem

# Disk usage metrics
with open('/proc/diskstats') as f:
    for line in f:
        if 'sda ' in line:  # replace sda with the name of your disk
            fields = line.split()
            reads, writes, time = int(fields[3]), int(fields[7]), int(fields[13])
            break
disk_usage = 100 * (reads + writes) / time

# Create a dictionary with the metrics and timestamp
metrics_dict = {
    "timestamp": timestamp,
    "cpu_usage": cpu_usage,
    "mem_usage": mem_usage,
    "disk_usage": disk_usage
}

# Convert the dictionary to JSON
metrics_json = json.dumps(metrics_dict)

# Write the metrics to a file with timestamp
with open('metrics.json', 'a') as f:
    f.write(metrics_json + '\n')