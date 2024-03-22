require ["fileinto", "imap4flags", "vnd.proton.expire"];

# This sieve is high up in the execution chain, as we want to short-circuit these from other sieves and centralize all security events.

# Common subjects relevant to security events
if header :contains "subject" ["security alert", "security notification", "login", "sign-on", 
"sign-in", "sign in", "sign on", "email address", "email change", "password", "terms of service",
"reset", "recovery key", "verify", "verification", "email removed", "new device", "email removal",
"access code", "privacy request", "terms and conditions"] 
{
    fileinto "Security";
    expire "day" "365";
    stop;
}

# Commonly used security services
elsif address :matches :domain "from" ["*lastpass.com", "*logme.in", "*okta.com", "*accounts.google.com", 
"*1password.com", "*haveibeenpwned.com", "*nextdns.io"]
{
    fileinto "Security"; 
    expire "day" "365";
    stop;
}
