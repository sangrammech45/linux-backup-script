# Linux Backup Script

**Author:** Sangram Jamdade

## Goal
A small Bash script that backs up a folder into a dated `.tar.gz` file, deletes old backups, and keeps a log of what it did.

## Usage
```bash
chmod +x backup.sh
./backup.sh SOURCE_DIR BACKUP_DIR [KEEP_DAYS]

# Example: back up ~/documents, keep 7 days of backups
./backup.sh ~/documents ~/backups 7
```
`KEEP_DAYS` is optional and defaults to 7.

## What it does
1. Checks that the source folder exists and exits with a clear error if not.
2. Creates `backup_YYYY-MM-DD_HH-MM-SS.tar.gz` in the backup folder.
3. Deletes backups older than `KEEP_DAYS` days.
4. Writes a timestamped log to `backup.log` in the backup folder.

## Run it nightly with cron
Open your crontab with `crontab -e` and add this line to run at 2:00 AM every day:
```
0 2 * * * /home/youruser/backup.sh /home/youruser/documents /home/youruser/backups 7
```

## How I tested it
- Ran it on a sample folder and confirmed the archive and log were created.
- Created a fake backup dated 10 days ago and confirmed it was deleted with `KEEP_DAYS=7`.
- Passed a folder that doesn't exist and confirmed it exits with an error message.

## Skills shown
Bash scripting, `tar`, `find`, `cron`, exit codes and error handling, logging.
