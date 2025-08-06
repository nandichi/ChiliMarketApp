# WordPress JWT Authentication Test Commands

## 1. Test JWT Token Endpoint

### Complete curl command:

```bash
curl -X POST https://chili-market.com/wp-json/jwt-auth/v1/token \
  -H "Content-Type: application/json" \
  -d '{
    "username": "your_username",
    "password": "your_password"
  }'
```

### Expected Responses:

**✅ Success (200):**

```json
{
  "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2NoaWxpLW1hcmtldC5jb20iLCJpYXQiOjE3MDk1NjQ4MDAsIm5iZiI6MTcwOTU2NDgwMCwiZXhwIjoxNzA5NTY4NDAwLCJkYXRhIjp7InVzZXIiOnsiaWQiOiIxIn19fQ.abc123...",
  "user_email": "user@chili-market.com",
  "user_nicename": "username",
  "user_display_name": "User Name"
}
```

**❌ Invalid Credentials (403):**

```json
{
  "code": "invalid_credentials",
  "message": "ERROR: The username or password you entered is incorrect.",
  "data": {
    "status": 403
  }
}
```

**❌ Plugin Not Found (404):**

```html
<!DOCTYPE html>
<html>
  <head>
    <title>404 Not Found</title>
  </head>
</html>
```

## 2. Test Token Validation

```bash
curl -X POST https://chili-market.com/wp-json/jwt-auth/v1/token/validate \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN_HERE"
```

## 3. Test API Call with Token

```bash
curl -X GET https://chili-market.com/wp-json/wp/v2/users/me \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_JWT_TOKEN_HERE"
```

## WordPress JWT Plugin Configuration

### Required Plugin:

- **JWT Authentication for WP-API** by Enrique Chavez

### wp-config.php Configuration:

```php
define('JWT_AUTH_SECRET_KEY', 'your-top-secret-key');
define('JWT_AUTH_CORS_ENABLE', true);
```

### .htaccess Configuration:

```apache
RewriteCond %{HTTP:Authorization} ^(.*)
RewriteRule ^(.*) - [E=HTTP_AUTHORIZATION:%1]
```

## Testing in the App

1. Open de ChiliMarketApp
2. Ga naar het login scherm
3. Klik op "Test API" knop
4. Bekijk de debug output voor JWT plugin status
5. Probeer in te loggen met echte credentials

## Troubleshooting

- **404 Error**: JWT plugin is niet geïnstalleerd of geactiveerd
- **403 Error**: Foute credentials, maar plugin werkt wel
- **500 Error**: Server configuratie probleem
- **CORS Error**: Voeg JWT_AUTH_CORS_ENABLE toe aan wp-config.php
