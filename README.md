<h1 align="center">
    <img src="https://raw.githubusercontent.com/Permify/permify/master/assets/permify-logo.svg" alt="Permify logo" width="336px" /><br />
    Permify Schema Validate GitHub Action
</h1>

<p align="center">
    <a href="https://github.com/Permify/permify" target="_blank"><img src="https://img.shields.io/github/license/Permify/permify?style=for-the-badge" alt="Permify Licence" /></a>&nbsp;
    <a href="https://discord.gg/MJbUjwskdH" target="_blank"><img src="https://img.shields.io/discord/950799928047833088?style=for-the-badge&logo=discord&label=DISCORD" alt="Permify Discord Channel" /></a>&nbsp;
</p>

<p align="center">
   <img width="605" alt="Screenshot 2023-04-06 at 1 55 00 AM" src="https://user-images.githubusercontent.com/39353278/232484847-ff4bd6ab-535d-4363-b3ff-167fab9d1ca4.png">
</p>

This repository runs the `permify validate` command on the given schema (authorization model) and relationships (sample authorization data) and assertions (sample check queries and results).

You can find detailed information on this repository in
the [Testing & Validation](https://docs.permify.co/docs/getting-started/testing) part of our documentation.

#### Example Schema Validation YAML File

```yaml
schema: >-
  entity user {}

  entity organization {

      relation admin @user
      relation member @user

      permission create_repository = (admin or member)
      permission delete = admin
  }

  entity repository {

      relation owner @user
      relation parent @organization

      permission push = owner
      permission read = (owner and (parent.admin and parent.member))
      permission delete = (parent.member and (parent.admin or owner))
  }

relationships:
  - "organization:1#admin@user:1"
  - "organization:1#member@user:1"
  - "repository:1#owner@user:1"

scenarios:
  - name: "scenario 1"
    description: "test description"
    checks:
      - entity: "repository:1"
        subject: "user:1"
        assertions:
          push : true
      - entity: "repository:2"
        subject: "user:1"
        assertions:
          push : false
      - entity: "repository:3"
        subject: "user:1"
        assertions:
          push : false
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

Permify is an **open-source authorization service** for creating and maintaining fine-grained authorizations across your
individual applications and services.

* [Permify website](https://permify.co)
* [Permify documentation](https://docs.permify.co/docs/intro)
* [Permify playground](https://play.permify.co)
* [Permify GitHub Repository](https://github.com/Permify/permify)

## Testing in Local

You can also test your new authorization model in your local (Permify clone) without using [permify-validate-action] at
all.

For that open up a new file and add a schema yaml file inside. Then build your project with, run `make run` command and
run `./permify validate {path of your schema validation file}`.

If we use the above example schema validation file, after
running `./permify validate {path of your schema validation file}` it gives a result on the terminal as:

[permify-validate-action]: https://github.com/Permify/permify-validate-action

## Community & Support

Join our [Discord channel](https://discord.gg/MJbUjwskdH) for issues, feature requests, feedbacks or anything else. We
love to talk about authorization and access control :heart:

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

