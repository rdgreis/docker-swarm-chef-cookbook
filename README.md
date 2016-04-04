# docker-swarm-cookbook-cookbook

Cookbook for setting up a Docker Swarm cluster.

## Supported Platforms

 - Ubuntu

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['docker-swarm-cookbook']['SWARM_TOKEN']</tt></td>
    <td>String</td>
    <td>Docker swarm cluster token</td>
    <td><tt></tt></td>
  </tr>
</table>

## Usage

### docker-swarm-cookbook::setup-master-node

Include `docker-swarm-cookbook` in your master node's `run_list`:

```json
{
  "run_list": [
    "recipe[docker-swarm-cookbook::setup-master-node]"
  ]
}
```

### docker-swarm-cookbook::setup-slave-node

Include `docker-swarm-cookbook` in your slave node's `run_list`:

```json
{
  "run_list": [
    "recipe[docker-swarm-cookbook::setup-slave-node]"
  ]
}
```

## License and Authors

Author:: Rodrigo Reis (rodrigo.reis@gmail.com)
