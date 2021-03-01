*SAP ABAP Removed Editor lock 
*Selection text
*LOCK	Editor lock flag
*PROGRAM	Program Name

REPORT zpoc_remove_editor_lock.

TABLES: trdir. "System table TRDIR

PARAMETERS: program LIKE trdir-name.
PARAMETERS: lock LIKE trdir-edtx.

START-OF-SELECTION.

  SELECT SINGLE * FROM trdir WHERE name = program.
  IF sy-subrc EQ 0.
    trdir-edtx = lock.
    MODIFY trdir.
    IF sy-subrc EQ 0.
      WRITE: / 'Editor Lock update Successful ', trdir-name.
      IF trdir-edtx = 'X'.
        WRITE: ' Lock'.
      ELSE.
        WRITE: ' UnLock'.
      ENDIF.
    ELSE.
      WRITE: / 'Editor Lock update Unsuccessful ', trdir-name.
    ENDIF.
  ELSE.
    WRITE: / 'No program found ', program.
  ENDIF.
