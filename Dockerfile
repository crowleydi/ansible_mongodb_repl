FROM rastasheep/ubuntu-sshd

ARG ssh_prv_key
ARG ssh_pub_key

RUN mkdir -p /root/.ssh && chmod 0700 /root/.ssh

# Add keys and set permissions
RUN echo "$ssh_prv_key" > /root/.ssh/id_rsa && \
	echo "$ssh_pub_key" > /root/.ssh/id_rsa.pub && \
	chmod 600 /root/.ssh/id_rsa && \
	chmod 600 /root/.ssh/id_rsa.pub
