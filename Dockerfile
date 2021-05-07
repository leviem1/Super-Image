# Choosing this for historical reasons, but should be simple enough to change
FROM centos:7

# Create regular user with wheel permission for more familiar feel
RUN adduser --groups wheel --uid 1001 si-user

# Install dependencies
RUN yum install -y sudo dos2unix

# Disable password for sudo for wheel users (beware wheel vs sudo groups on other base images)
RUN echo '%wheel  ALL=(ALL)       NOPASSWD: ALL' > /etc/sudoers.d/50-wheel-nopasswd \
&& echo '%sudo  ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers.d/50-wheel-nopasswd

# Create temporary folder to copy packages to
RUN mkdir /tmp/super-linter-packages

# Change to package folder
WORKDIR /tmp/super-linter-packages

# Copy installer to package folder
COPY lib/install-packages .

# Copy packages to package folder
COPY packages packages

# Convert files in case they were copied from Windows
RUN find . -type f -exec dos2unix "{}" \;

# Install packages and remove
RUN chmod +x install-packages && ./install-packages

# Move out of repo folder before removing
WORKDIR /home/si-user

# Clean up repo folder
RUN rm -rf /tmp/super-linter-repo

# Change to regular user
USER si-user

# Login
CMD ["/bin/bash", "--login"]