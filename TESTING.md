Testing
=======

Preparation
-----
1. Install ChefDK
2. Install ruby (gem) dependencies
```
chef exec bundle install
```
3. Install chef (cookbook) dependencies
```
chef exec bundle exec berks install
```

Local
-----
```
chef exec bundle exec rake unit
```

The above runs:

 - rubocop
 - `knife cookbook test` tests
 - Food Critic lint
 - Chefspec tests

Chefspec tests (the interesting part) are in `spec/`.

Integration
-----------
```
chef exec bundle exec kitchen test
```

 See `.kitchen.yml` and `test/` directory for details.

 It is important to check if the applied hostname and fqdn values remain the same
 also after machine reboot. As it is impossible to reboot using kitchen, it has to
 be done manually:

 - run `kitchen converge` and `kitchen verify` to ensure your run is error-free,
 - log in to the machine. If you're on a Debian-based system, you need to ensure
 that the `/tmp` folder won't be deleted with rebooting, since that's where busser
 resides. If `/tmp` is deleted, `kitchen verify` will fail after reboot even if a
 manual check confirms that hostname, fqdn and dnsdomainname are correct. You can
 preserve the `/tmp` folder by typing the following in your terminal:
 `sudo find /etc/default/rcS -type f -exec sed -i 's/TMPTIME=0/TMPTIME=-1/g' {} \;`
 - run `sudo reboot`,
 - wait for the machine to reboot and run `kitchen verify` again.

Other Rake Tasks
----------------
Run `chef exec rake -T` to see other tasks.

Notes
-----
The `chef exec` part runs the chefdk embedded ruby which ensures the correct gems are used for testing.  `bundle exec` uses the `Gemfile` to ensure that the correct gem set is being used for the current cookbook.