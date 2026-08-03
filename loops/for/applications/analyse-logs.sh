#!/bin/bash

LOG_DIR="/Users/sebastiangomez/logs"
ERROR_PATTERNS=("ERROR" "FATAL" "CRITICAL") 
REPORT_FILE="$LOG_DIR/log_analysis_report_copy.txt"

echo "ANALYSING LOG FILES" > "$REPORT_FILE"
echo "===================" >> "$REPORT_FILE"

echo -e "\nList of log files updated" >> "$REPORT_FILE"
LOG_FILES=("$LOG_DIR/system.log" "$LOG_DIR/application.log")
echo "${LOG_FILES[@]}" >> "$REPORT_FILE" 

for LOG_FILE in "${LOG_FILES[@]}"; do

    echo -e "\n" >> "$REPORT_FILE"
    echo "================================" >> "$REPORT_FILE"
    echo "=========$(basename "$LOG_FILE")=========" >> "$REPORT_FILE"
    echo "================================" >> "$REPORT_FILE"

    for PATRON in "${ERROR_PATTERNS[@]}"; do
        echo -e "\nSearching $PATRON logs in $LOG_FILE file" >> "$REPORT_FILE"
        
        grep "$PATRON" "$LOG_FILE" >> "$REPORT_FILE"

        TOTAL_FOUND=$(grep -c "$PATRON" "$LOG_FILE") 
        echo "📊 Total  events ($PATRON) found: $TOTAL_FOUND" >> "$REPORT_FILE"
        echo "------------------------------------" >> "$REPORT_FILE"




    done

done

echo -e "\nLog analysis completed and report saved in: $REPORT_FILE"



