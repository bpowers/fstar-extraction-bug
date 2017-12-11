module Test

module U8 = FStar.UInt8

val test_all:
  i:UInt8.t{0 < (U8.v i) /\ (U8.v i) <= 64} ->
  Tot (bool)
let rec test_all i =
  let open FStar.UInt8 in
  match i with
  | 0uy -> true
  | _ -> (let m = i -^ 1uy in
         true && test_all m)

val test: unit -> Tot (bool)
let test () =
  test_all 64uy
