# Tail log viewer package

Tail log viewer is a simple and short script that moves the editor to the bottom when the file changes.

The editor will move to the bottom of the buffer when a change occurs. The change can be:
- external file change (most likely when viewing a log file)
  + when this occurs and there are NO un saved changes, the screen will move to the bottom
  + this is the most common use case
- internal buffer change
