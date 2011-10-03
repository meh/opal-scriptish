Support Scriptish scripting in Ruby with Opal
=============================================

To start a scriptish project just copy the `skel` directory where you want and write
your main file in the directory, the name of the file will be used in the resulting
output.

You can put your additional files in the `lib/` directory, those will be automatically
included and generated, you can require them in the *main*.

To install additional libraries you can use an `Opalfile` that will install the gems in the
`vendor/` directory.
