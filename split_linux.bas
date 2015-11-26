CLS
RANDOMIZE TIMER
REM  Dump splitter
REM  By SmokingWheels for Loklak.org Nov 2015
REM  Must create Directoy's First
REM  For Linux just change file locations Input and Output eg /home/john/Downloads/
REM  Change lines 13,14 and location in 37.  Paths in line 14 and 37 must match. Line 25 sets number of messages per file.
REM  Runs faster with screen off. Has Hz counter for number of messages processing speed.

TIMER ON
ON TIMER(1) GOSUB health
PRINT "CTRL Break to end."
OPEN "/media/Storage/loklak_server/data/dump/import/lokraw.txt" FOR INPUT AS #1
OPEN "/home/greg/Downloads/lokdata/messages_0_oct2015.txt" FOR OUTPUT AS #2
findex = 0

newdata:
index# = 0
message# = 0
DO WHILE NOT EOF(1)
    newinput:
    LINE INPUT #1, a$
    IF (LEN(a$) < 3) AND NOT EOF(1) THEN GOTO newinput
    REM    IF RIGHT$(a$, 1) = CHR$(34) THEN a$ = MID$(a$, 1, LEN(a$) - 1)
    PRINT #2, a$
    message# = message# + 1
    index# = index# + 1
    REM Number of Records/Messages lines per file name
    IF index# = 500000 THEN EXIT DO
LOOP
CLOSE #2

findex = findex + 1
REM Double m and STR$ problem incase you just want a file name with a number.
filename$ = "mmessages_" + STR$(findex) + "_oct2015" + ".txt"
filename$ = RIGHT$(filename$, LEN(filename$) - 1)
filename$ = "/home/greg/Downloads/lokdata/" + filename$
IF NOT EOF(1) THEN
    OPEN filename$ FOR OUTPUT AS #2
    LOCATE 10, 5
    PRINT filename$
    GOTO newdata
END IF

CLOSE #1: CLOSE #2

END

health:
LOCATE 4, 5
PRINT "Total Messages -  Hz processing"
LOCATE 5, 5
hz1# = hz#
hz# = message#
PRINT message#, message# - hz1#
RETURN
