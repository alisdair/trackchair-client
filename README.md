# TrackChair API Client

REST API client for [TrackChair][trackchair].

[trackchair]: https://www.trackchair.com/

## Usage

Requires Ruby 2.0 and bundler (`gem install bundler`).

Basics:

    git clone https://github.com/alisdair/trackchair-client.git
    cd trackchair-client
    bundle install

First, log in to the API to create an access token by running `bundle exec bin/trackchair-login`.

This will ask for your email and password, and store an API token in `~/.trackchair-client`. Note: the token will expire after 2 weeks of inactivity.

There are two example utilities provided with the package: `trackchair-papers`, and `trackchair-program-entry`. Use these as templates to build your own programs.

## API documentation

Coming soon? Here are the Rails routes in case you feel like experimenting:

```ruby
# API
namespace :api do
  resources :tokens, only: [:create]
  resources :tracks, only: [:index]
  resources :papers, only: [:index, :show] do
    get :manuscript, on: :member
    resources :tags, only: [:index]
    resources :comments, only: [:index, :create, :destroy]
  end
end
```

## License

MIT.
