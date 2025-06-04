CERT_DIR=certs
CERT_KEY=$(CERT_DIR)/server.key
CERT_CERT=$(CERT_DIR)/server.cert

.PHONY: all generate-certs clean-certs

all: generate-certs

generate-certs:
	@mkdir -p $(CERT_DIR)
	docker run --rm -v "$$(pwd)/$(CERT_DIR):/certs" alpine sh -c \
		"apk add --no-cache openssl && \
		openssl req -x509 -newkey rsa:4096 -sha256 -nodes \
		-keyout /certs/server.key -out /certs/server.cert -days 365 \
		-subj '/CN=localhost'"
	@echo "Certificados gerados em $(CERT_DIR)/"

clean-certs:
	@rm -f $(CERT_KEY) $(CERT_CERT)
	@echo "Certificados removidos."
