## Description

Installs/Configures [Adobe AEM](http://www.adobe.com/solutions/web-experience-management.html).

## Requirements

### Platforms

* CentOS 6

### Cookbooks

Required [Opscode Cookbooks](https://github.com/opscode-cookbooks/)

* [java](https://github.com/opscode-cookbooks/java)

## Attributes

These attributes are under the `node['aem']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
install_path | location to install AEM | String | /opt/aem
user | user to run AEM | String | aem
url | Url of AEM | String | ""
checksum | Checksum of AEM | String | ""

### AEM JVM Attributes

These attributes are under the `node['aem']['jvm']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
maximum_permgen | JVM maximum PermGen memory | String | 256m
xmx | JVM Xmx | String | 1024M

### AEM License Attributes

These attributes are under the `node['aem']['license']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
customer | AEM customer license | String | nil
downloadId | AEM downloadId license | String | nil

## Recipes

* `recipe[aem]` Empty recipe
* `recipe[aem::author]` Installs/configures AEM Author
* `recipe[aem::publish]` Installs/configures AEM Publish

## Contributing

Please use standard issues/pull requests.

## License and Contributors

Please see license information in: [LICENSE](LICENSE)

* Sergio Leone <sergio.leone@qvc.com>
