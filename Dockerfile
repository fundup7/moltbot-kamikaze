# 1. Use Alpine (Tiny Linux)
FROM node:22-alpine

WORKDIR /app

# 2. Install dependencies
RUN apk add --no-cache git python3 make g++

# 3. Install Moltbot
RUN npm install -g moltbot@latest --omit=dev

# 4. Create config folders
RUN mkdir -p /root/.moltbot

# 5. Expose Port
EXPOSE 3000

# 6. THE FIX: Use Environment Variable for Memory (No paths needed)
# This forces Node to respect the limit no matter how we start it
ENV NODE_OPTIONS="--max-old-space-size=384 --optimize_for_size"

# 7. Start command (Let the system find the bot)
CMD ["moltbot", "gateway", "--port", "3000", "--host", "0.0.0.0"]