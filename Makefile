IMAGE_NAME = suitcase
CONTAINER_NAME = suitcase_dev

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run -it --rm --name $(CONTAINER_NAME) $(IMAGE_NAME)

run-mount:
	docker run -it --rm \
		-v $(PWD)/dotfiles:/root/dotfiles \
		--name $(CONTAINER_NAME) \
		$(IMAGE_NAME)

shell:
	docker exec -it $(CONTAINER_NAME) zsh

logs:
	docker logs $(CONTAINER_NAME)
