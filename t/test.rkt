#lang racket

(require rackunit
         apertium-kaz-tat)

(check-equal? (kaz-tat "а") "а")
(check-equal? (kaz-tat "а-а-а-а-а") "а-а-а-а-а")
(check-equal? (kaz-tat "а дәрумені") "а витамины")
(check-equal? (kaz-tat "абажа") "зур сандык")
(check-equal? (kaz-tat "абайлаңқырап") "сакланыбрак")