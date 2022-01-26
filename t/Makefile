.SUFFIXES:

check: bats-core
	./bats-core/bin/bats *.bats

bats-core:
	git clone https://github.com/bats-core/bats-core
	git -C bats-core checkout 429e86417b52f09d491778bb3cd14eaa1d25462f
	git clone https://github.com/bats-core/bats-support
	git -C bats-support checkout d140a65044b2d6810381935ae7f0c94c7023c8c3
	git clone https://github.com/bats-core/bats-assert
	git -C bats-assert checkout 4bdd58d3fbcdce3209033d44d884e87add1d8405
	git clone https://github.com/bats-core/bats-file
	git -C bats-file checkout 17fa557f6fe28a327933e3fa32efef1d211caa5a
