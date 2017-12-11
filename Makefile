include ./Makefile.include

.PHONY=lib all

# OCaml variables
OCAMLOPT := $(OCAMLOPT) -w -8-20-26-28-10
OCAML_INCLUDES=-I ../code/lib/ml ../code/lib/ml/hacllib.cmxa

all:
	$(MAKE)	test.exe


EXTRACTED=FStar_Seq_Base.ml FStar_Seq.ml FStar_Seq_Properties.ml FStar_Math_Lib.ml FStar_BitVector.ml FStar_UInt.ml

NOEXTRACT=$(FSTAR_DEFAULT_ARGS) $(addprefix --no_extract Hacl., UInt64 UInt32 UInt8)

SPEC_FILES=	Test.fst

hints: $(addsuffix .hints, $(SPEC_FILES))
verify: $(addsuffix -verify, $(SPEC_FILES))
all-hints: hints
all-ver: verify

FSTAR_EXTRACT=$(FSTAR) --codegen OCaml --lax $(NOEXTRACT)

test.exe: Test.fst
	mkdir -p test-spec
	$(FSTAR_EXTRACT) --odir test-spec $^
	@echo 'let _ = print_string (if test() then "SUCCESS\n" else failwith "Test failed\n")' >> test-spec/Test.ml
	$(OCAMLOPT) -I test-spec $(OCAML_INCLUDES) test-spec/Test.ml -o $@
	./$@
