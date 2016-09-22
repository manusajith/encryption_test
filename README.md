# Encryption

## Assumptions

- A universal key is used for encryption purposes
  - Ideally, key lookup should be based out on some user/client entity
- There is a client process which takes responsibility to spawn a new
  Encryption Process for its use.
  - this assumption kind a enforces knowledge of spawning and knowing
    pid for Encryption use

## Enhancements

- If we plan on using this as a service, its better to limit the process
  using poolboy or custom logic to not spawn only sufficient processes
- Keys can be cached either in ETS tables or a dedicated process(like
  Agent) can maintain key cache for us
  - betterment on key read from disk

## Performance considerations

- Encryption GenServer encrypts in blocking call so with one process, we
  need to wait for already started process to finish and then next would
be served or scheduled
- As shown with tests, its not a problem if there is some other process
  which is invoking exclusive instance of our GenServer for its use
- Lets discuss and improve

## TODO

- Check the application in some parent application like phoenix app or
  other mix project

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `encryption` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:encryption, "~> 0.1.0"}]
    end
    ```

  2. Ensure `encryption` is started before your application:

    ```elixir
    def application do
      [applications: [:encryption]]
    end
    ```

