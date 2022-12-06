
<h1 align="center">
    <img src="https://raw.githubusercontent.com/Permify/permify/master/assets/permify-logo.svg" alt="Permify logo" width="336px" /><br />
    Permify Schema Validate GitHub Action
</h1>

<p align="center">
    <a href="https://github.com/Permify/permify" target="_blank"><img src="https://img.shields.io/github/license/Permify/permify?style=for-the-badge" alt="Permify Licence" /></a>&nbsp;
    <a href="https://discord.gg/MJbUjwskdH" target="_blank"><img src="https://img.shields.io/discord/950799928047833088?style=for-the-badge&logo=discord&label=DISCORD" alt="Permify Discord Channel" /></a>&nbsp;
</p>

This repository runs the `permify validate` command on the given schema (authorization model) and relationships (sample authorization data) and assertions (sample check queries and results).

#### Example Schema Validation YAML File

```yaml
schema: >-
    entity user {}

    entity organization {

        relation admin @user
        relation member @user

        action create_repository = (admin or member)
        action delete = admin
    }

    entity repository {

        relation owner @user
        relation parent @organization

        action push = owner
        action read = (owner and (parent.admin and parent.member))
        action delete = (parent.member and (parent.admin or owner))
    }

relationships:
    - "organization:1#admin@user:1"
    - "organization:1#member@user:1"
    - "repository:1#owner@user:1"

assertions:
    - "can user:1 push repository:1": true
    - "can user:1 push repository:2": false
    - "can user:1 push repository:3": false
```

### Usage
Add the action following your workflow:

- With local file
```yaml
steps:
- uses: "permify/permify-validate-action@v1"
  with:
    validationFile: "test.yaml"
```

- With url
```yaml
steps:
- uses: "permify/permify-validate-action@v1"
  with:
    validationFile: "https://gist.github.com/permify-bot/bb8f95acb64525d2a41688ae0a6f4274"
```

Permify is an **open-source authorization service** for creating and maintaining fine-grained authorizations accross your individual applications and services.

* [Permify website](https://permify.co)
* [Permify documentation](https://docs.permify.co/docs/intro)
* [Permify playground](https://play.permify.co)
* [Permify GitHub Repository](https://github.com/Permify/permify)

## Community & Support
Join our [Discord channel](https://discord.gg/MJbUjwskdH) for issues, feature requests, feedbacks or anything else. We love to talk about authorization and access control :heart:

<p align="left">
<a href="https://discord.gg/MJbUjwskdH">
 <img height="70px" width="70px" alt="permify | Discord" src="https://user-images.githubusercontent.com/39353278/187209316-3d01a799-c51b-4eaa-8f52-168047078a14.png" />
</a>
<a href="https://twitter.com/GetPermify">
  <img height="70px" width="70px" alt="permify | Twitter" src="https://user-images.githubusercontent.com/39353278/187209323-23f14261-d406-420d-80eb-1aa707a71043.png"/>
</a>
<a href="https://www.linkedin.com/company/permifyco">
  <img height="70px" width="70px" alt="permify | Linkedin" src="https://user-images.githubusercontent.com/39353278/187209321-03293a24-6f63-4321-b362-b0fc89fdd879.png" />
</a>
</p>

