Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, '3OQf20kyldfWvn9hEBE8w', 'FIFrlQNwfdVAhbEUQ31jMb3EBwWypps7e6KAtPB6hk'
  provider :facebook, 'c3dad49bc86d3e0a0a2a24a96c76c5dc', 'a0ead1f54d7f57d8e344ab47099862ac'
end