# ZJSON <sub><sup>-  <sub><sup>ZScript JSON Parser (with trailing comma and single/multi-line comment support)</sup></sub></sup></sub>

This is a JSON parsing library for [ZScript](https://zdoom.org/wiki/ZScript).

Includes a [usage example](.example/zjson-example.pk3) and a [small test suite](.example/zjson-test.pk3).

It supports, in addition to strict JSON: trailing commas, single-quote strings, and single/multi-line comments (C/C++-style).

To use in your mod, just generate the prefixes, copy over the `generated/ZJSON` folder, and add `#include "ZJSON/Include.zs"` to your main ZScript file.

## Generating Prefixes:
Run `generate.sh [your prefix]` on linux/wsl/msys/cygwin. The prefixed files will be in the `generated` folder.

## How to Use:

Call `JSON.parse` with a string that contains JSON text, it will return either a `JsonElement` in case of success, or a `JsonError` in case of failure. Call `JsonElement::serialize` to generate JSON back from a `JsonElement`.

## Types:
* [JsonError](ZJSON/JsonBase.zs) - NOT a Json Element. If `JSON.parse` return this, it means that the parsing failed, the error is in `JsonError.what`, it contains line number and some extra information.
* [JsonElement](ZJSON/JsonBase.zs) -  One of `JsonObject`, `JsonArray`, `JsonString`, `JsonNumber`, `JsonBool`, or `JsonNull`
* [JsonObject](ZJSON/JsonObject.zs) - Hash Table that holds `JsonElement` values with `String` keys
* [JsonArray](ZJSON/JsonArray.zs) - Dynamic Array that holds `JsonElement` values
* [JsonString](ZJSON/JsonBase.zs) - String Literal
* [JsonNumber](ZJSON/JsonBase.zs) - One of `JsonInt` or `JsonDouble`
* [JsonInt](ZJSON/JsonBase.zs) - Integral Literal
* [JsonDouble](ZJSON/JsonBase.zs) - Decimal Literal
* [JsonBool](ZJSON/JsonBase.zs) - A `true`/`false` Literal
* [JsonNull](ZJSON/JsonBase.zs) - A `null` Literal
