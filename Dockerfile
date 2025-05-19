# Sử dụng Node.js image chính thức làm base image
FROM node:20-alpine

# Thiết lập thư mục làm việc
WORKDIR /app/admin

# Sao chép các file cấu hình package.json và package-lock.json (nếu có)
COPY package.json .
COPY package-lock.json* .

# Cập nhật package và cài đặt phụ thuộc
RUN apk update && apk add --no-cache python3 make g++
RUN npm ci

# Sao chép toàn bộ mã nguồn
COPY . .

# Build ứng dụng Next.js cho production
RUN npm run build

# Mở port 8000 (mặc định cho Next.js Storefront)
EXPOSE 8000

# Lệnh chạy ứng dụng
CMD ["npm", "start"]