#lang racket

; Racket interface for apertium-kaz-tat
;
; REQUIRES: apertiumpp package.
; https://taruen.github.io/apertiumpp/apertiumpp/ gives info on how to install
; it.

(provide kaz-tat
         kaz-tat-from-pretransfer-to-biltrans
         kaz-tat-from-t1x-to-postgen
         tat-kaz
         tat-kaz-from-pretransfer-to-biltrans
         tat-kaz-from-t1x-to-postgen)

(require pkg/lib
         rackunit
         rash
         apertiumpp/streamparser)

(define (symbol-append s1 s2)
  (string->symbol (string-append (symbol->string s1) (symbol->string s2))))

(define A-KAZ-TAT './)
(define A-KAZ-TAT-BIL (symbol-append A-KAZ-TAT 'kaz-tat.autobil.bin))
(define A-KAZ-TAT-T1X (symbol-append A-KAZ-TAT 'apertium-kaz-tat.kaz-tat.t1x))
(define A-KAZ-TAT-T1X-BIN (symbol-append A-KAZ-TAT 'kaz-tat.t1x.bin))
(define A-KAZ-TAT-T2X (symbol-append A-KAZ-TAT 'apertium-kaz-tat.kaz-tat.t2x))
(define A-KAZ-TAT-T2X-BIN (symbol-append A-KAZ-TAT 'kaz-tat.t2x.bin))
(define A-KAZ-TAT-GEN (symbol-append A-KAZ-TAT 'kaz-tat.autogen.bin))
(define A-KAZ-TAT-PGEN (symbol-append A-KAZ-TAT 'kaz-tat.autopgen.bin))
(define A-TAT-KAZ-BIL (symbol-append A-KAZ-TAT 'tat-kaz.autobil.bin))
(define A-TAT-KAZ-T1X (symbol-append A-KAZ-TAT 'apertium-kaz-tat.tat-kaz.t1x))
(define A-TAT-KAZ-T1X-BIN (symbol-append A-KAZ-TAT 'tat-kaz.t1x.bin))
(define A-TAT-KAZ-T2X (symbol-append A-KAZ-TAT 'apertium-kaz-tat.tat-kaz.t2x))
(define A-TAT-KAZ-T2X-BIN (symbol-append A-KAZ-TAT 'tat-kaz.t2x.bin))
(define A-TAT-KAZ-GEN (symbol-append A-KAZ-TAT 'tat-kaz.autogen.bin))
(define A-TAT-KAZ-PGEN (symbol-append A-KAZ-TAT 'tat-kaz.autopgen.bin))

(define (kaz-tat s)
  (parameterize ([current-directory (pkg-directory "apertium-kaz-tat")])
    (rash
     "echo (values s) | apertium -d . kaz-tat")))

(define (kaz-tat-from-pretransfer-to-biltrans s)
  (parameterize ([current-directory (pkg-directory "apertium-kaz-tat")])
    (rash
     "echo (values s) | apertium-pretransfer | "
     "lt-proc -b (values A-KAZ-TAT-BIL)")))

(define (kaz-tat-from-t1x-to-postgen s)
  (parameterize ([current-directory (pkg-directory "apertium-kaz-tat")])
    (rash
     "echo (values s) | "
     "apertium-transfer -b (values A-KAZ-TAT-T1X) (values A-KAZ-TAT-T1X-BIN) | "
     "apertium-transfer -n (values A-KAZ-TAT-T2X) (values A-KAZ-TAT-T2X-BIN) | "
     "lt-proc -g (values A-KAZ-TAT-GEN) | "
     "lt-proc -p (values A-KAZ-TAT-PGEN)")))

(define (tat-kaz s)
  (parameterize ([current-directory (pkg-directory "apertium-kaz-tat")])
    (rash
     "echo (values s) | apertium -d . tat-kaz")))

(define (tat-kaz-from-pretransfer-to-biltrans s)
  (parameterize ([current-directory (pkg-directory "apertium-kaz-tat")])
    (rash
     "echo (values s) | apertium-pretransfer | "
     "lt-proc -b (values A-TAT-KAZ-BIL)")))

(define (tat-kaz-from-t1x-to-postgen s)
  (parameterize ([current-directory (pkg-directory "apertium-kaz-tat")])
    (rash
     "echo (values s) | "
     "apertium-transfer -b (values A-TAT-KAZ-T1X) (values A-TAT-KAZ-T1X-BIN) | "
     "apertium-transfer -n (values A-TAT-KAZ-T2X) (values A-TAT-KAZ-T2X-BIN) | "
     "lt-proc -g (values A-TAT-KAZ-GEN) | "
     "lt-proc -p (values A-TAT-KAZ-PGEN)")))
