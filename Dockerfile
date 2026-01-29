# 1. Use Alpine (Tiny Linux)
FROM node:22-alpine

WORKDIR /app

# 2. Install dependencies (No Chromium/Browser stuff)
RUN apk add --no-cache git python3 make g++

# 3. Install Moltbot (Production only, no dev tools)
RUN npm install -g moltbot@latest --omit=dev

# 4. Create config folders
RUN mkdir -p /root/.moltbot

# 5. Expose Port
EXPOSE 3000

# 6. THE SECRET SAUCE (Memory Flags)
# --max-old-space-size=384: Caps memory at 384MB (leaving 128MB for OS overhead)
# --optimize_for_size: Tells V8 engine to care about RAM, not speed.
CMD ["node", "--max-old-space-size=384", "--optimize_for_size", "/usr/local/bin/moltbot", "gateway", "--port", "3000", "--host", "0.0.0.0"]