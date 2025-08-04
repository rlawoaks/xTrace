#!/bin/bash
USER_ID="abcdefg"
TITLE="$1"
Y=$(date +%Y); M=$(date +%m); D=$(date +%d)
FILE="docs/tickets/${USER_ID}/${Y}/${M}/${D}/issue-$RANDOM.md"
mkdir -p "$(dirname "$FILE")"
cat > "$FILE" <<EOT
#  Ticket: $TITLE

**생성일:** $(date '+%Y-%m-%d %H:%M:%S')  
**작성자 ID:** $USER_ID  

---

##  내용

- 설명: $TITLE
- 상태: 신규
- 우선순위: 보통

EOT
echo "Created ticket at: $FILE"
