# Build phase - Use a bases image and create a build
# In prod we can give each phase/block a name as below, this will help us to refer each block by its name
# FROM node:alpine as builder
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# build will be created at /app/build
# Run phase - Use another base image and copy the build from previous step
# Remember any single step can have only one FROM step, so now docker automatically
# knows that next step has been started
FROM nginx
# this --from=0 is refering to first block
# we can also refer it to by its name, if given above as 
# COPY --from=builder
COPY --from=0 /app/build /usr/share/nginx/html
# above is COPY --from=0       /app/build   /usr/share/nginx/html
#          COPY Phase/block    from folder       to folder
