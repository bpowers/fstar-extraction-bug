open Prims
let rec test_all: FStar_UInt8.t -> Prims.bool =
  fun i  ->
    match i with
    | _0_19 when _0_19 = (FStar_UInt8.__uint_to_t (Prims.parse_int "0")) ->
        true
    | uu____10 ->
        true &&
          (test_all
             (FStar_UInt8.sub i (FStar_UInt8.uint_to_t (Prims.parse_int "1"))))
let test: Prims.unit -> Prims.bool =
  fun uu____14  -> test_all (FStar_UInt8.uint_to_t (Prims.parse_int "64"))let _ = print_string (if test() then "SUCCESS\n" else failwith "Test failed\n")
