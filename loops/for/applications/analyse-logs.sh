#!/bin/bash

LOG_DIR="/Users/sebastiangomez/repositorios_git/linux/loops/for/applications"
LOG_FILE="$LOG_DIR/application.log"
REPORT_FILE="$LOG_DIR/log_analysis_report.txt"

ERROR_PATTERNS=("ERROR" "FATAL" "CRITICAL") 


echo "ANALYSING LOG FILES" > "$REPORT_FILE"
echo "===================" >> "$REPORT_FILE"

echo -e "\nList of log files updated" >> "$REPORT_FILE"

LOG_FILES=("$LOG_DIR/application.log")
echo "$LOG_FILES" >> "$REPORT_FILE" 


echo -e "\n" >> "$REPORT_FILE"
echo "================================" >> "$REPORT_FILE"
echo "=========$(basename "$LOG_FILES")=========" >> "$REPORT_FILE"
echo "================================" >> "$REPORT_FILE"

for PATRON in "${ERROR_PATTERNS[@]}"; do
    echo -e "\nSearching $PATRON logs in $(basename "$LOG_FILES") file" >> "$REPORT_FILE"
        
    grep "$PATRON" "$LOG_FILES" >> "$REPORT_FILE"

    TOTAL_FOUND=$(grep -c "$PATRON" "$LOG_FILES") 
    echo "📊 Total  events ($PATRON) found: $TOTAL_FOUND" >> "$REPORT_FILE"
    echo "------------------------------------" >> "$REPORT_FILE"




done

echo -e "\nLog analysis completed and report saved in: $REPORT_FILE"



