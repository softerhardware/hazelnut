## Quartus tools quartus_sh and quartus_cpf must be in your path

all: hazelnut_ep4


hazelnut_ep4/hazelnut_ep4.sof:
	quartus_sh --flow compile hazelnut -c hazelnut_ep4

hazelnut_ep4/hazelnut_ep4.jic: hazelnut_ep4/hazelnut_ep4.sof
	quartus_cpf -c hazelnut_ep4.cof

hazelnut_ep4/hazelnut_ep4jic.jam: hazelnut_ep4/hazelnut_ep4.jic
	quartus_cpf -c hazelnut_ep4/hazelnut_ep4.jic hazelnut_ep4/hazelnut_ep4jic.jam

hazelnut_ep4/hazelnut_ep4sof.jam: hazelnut_ep4/hazelnut_ep4.sof
	quartus_cpf -c hazelnut_ep4/hazelnut_ep4.sof hazelnut_ep4/hazelnut_ep4sof.jam

hazelnut_ep4/hazelnut_ep4sof.svf: hazelnut_ep4/hazelnut_ep4.sof
	quartus_cpf -c -q 12.0MHz -g 3.3 -n p hazelnut_ep4/hazelnut_ep4.sof hazelnut_ep4/hazelnut_ep4sof.svf

hazelnut_ep4: hazelnut_ep4/hazelnut_ep4.sof hazelnut_ep4/hazelnut_ep4.jic 


oldtarget: hazelnut_ep4/hazelnut_ep4jic.jam hazelnut_ep4/hazelnut_ep4sof.jam hazelnut_ep4/hazelnut_ep4sof.svf
	mkdir -p release/hazelnut_ep4
	cp hazelnut_ep4/hazelnut_ep4.sof release/hazelnut_ep4
	cp hazelnut_ep4/hazelnut_ep4.rbf release/hazelnut_ep4
	cp hazelnut_ep4/hazelnut_ep4.jic release/hazelnut_ep4
	cp hazelnut_ep4/hazelnut_ep4jic.jam release/hazelnut_ep4
	cp hazelnut_ep4/hazelnut_ep4sof.jam release/hazelnut_ep4
	cp hazelnut_ep4/hazelnut_ep4sof.svf release/hazelnut_ep4

clean:
	rm -rf hazelnut_ep4 

realclean:
	rm -rf db incremental_db

.PHONY: hazelnut_ep4 all clean
