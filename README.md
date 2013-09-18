# TeamCity server chef cookbook

Have been tested with Ubuntu Server 13.04.

## Usage

How to provision vagrant VM:

```bash
bundle install
vagrant up
knife solo bootstrap vagrant@localhost nodes/application.json.sample -p 2222 -i ~/.vagrant.d/insecure_private_key
```
