CWD=$(shell pwd)

.PHONY: ct
all: compile escriptize eunit ct xref dialyze edoc
ci: compile escriptize eunit ct xref dialyze

compile:
	@./epm as dev compile

xref:
	@./epm as dev xref

clean:
	@./epm clean

ct: escriptize
	@CMD_TOOL=$(CWD)/bbmustache ./epm ct

cover:
	@./epm cover

eunit:
	@./epm eunit

edoc:
	@./epm as doc edoc

start:
	@./epm as dev shell

dialyze:
	@./epm as dev dialyzer

bench:
	@./epm as test compile
	@./epm as bench compile
	@./benchmarks/bench.escript

escriptize:
	@./epm as dev escriptize
	@cp _build/dev/bin/bbmustache .

install: escriptize
	cp bbmustache /usr/local/bin
