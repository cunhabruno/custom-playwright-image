ARG PL_VERSION
FROM mcr.microsoft.com/playwright:$PL_VERSION
RUN apt update -y && apt upgrade -y && apt install unzip -y
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    aws --version
