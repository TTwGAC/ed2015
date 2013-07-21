#!/bin/sh
ruby ./knit-fonts.rb > test.knit
ruby ./knit-parse.rb test.knit > test.html
open test.html
