run:
	go run main.go

build_test:
	docker build -t robot .

test:
	mkdir -p `pwd`/testresults
	docker run --rm -v `pwd`/tests:/mnt/tests -v `pwd`/testresults:/mnt/results --network="host" robot

clean:
	rm -rf `pwd`/testresults
