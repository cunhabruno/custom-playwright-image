ARG PL_VERSION
FROM mcr.microsoft.com/playwright:$PL_VERSION
RUN apt install openjdk-8-jdk -y
