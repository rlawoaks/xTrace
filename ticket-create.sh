#!/bin/bash
# 티켓 자동 생성 스크립트
# 사용: ./ticket-create.sh "이슈 제목"

USER_ID="abcdEFgh"               # ↔ 필요시 사용자 ID 로직 변경
TITLE="$1"                       # 첫 번째 인수를 티켓 제목으로 사용

# 날짜 계산
Y=$(date +%Y);  M=$(date +%m);  D=$(date +%d)
RAND=$RANDOM                      # 임의 번호
DIR="docs/tickets/${USER_ID}/${Y}/${M}/${D}/issue-${RAND}"
FILE="${DIR}/index.md"            # ⬅️ .md 대신 index.md 로 저장

# 디렉터리 생성
mkdir -p "${DIR}"

# 티켓 본문 작성
cat > "${FILE}" <<EOF
# 🐞 Ticket: ${TITLE}

**생성일:** $(date '+%Y-%m-%d %H:%M:%S')  
**작성자 ID:** ${USER_ID}  

---

## 📌 내용

- 설명: ${TITLE}
- 상태: 신규
- 우선순위: 보통
EOF

echo "[✅] Created ticket at: ${FILE}"

# -------------------------------
# ▶ Tickets 목록(index.md) 자동 갱신
# -------------------------------
INDEX="docs/tickets/index.md"

# 첫 실행 시 헤더 생성
if ! grep -q "## 티켓 목록" "$INDEX" 2>/dev/null; then
  cat > "$INDEX" <<EOT
# 📑 Tickets 목록

아래는 생성된 티켓들의 링크입니다:

EOT
fi

# 상대 경로 링크 추가 (.md 없이 디렉터리 링크)
REL_PATH="\$(echo "${DIR}" | sed 's|docs/||')"
echo "- [${TITLE}](./\${REL_PATH}/)" >> "$INDEX"
