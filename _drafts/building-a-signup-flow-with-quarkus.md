---
layout: post
title: building a login flow with quarkus
---

[Quarkus code start page](https://code.quarkus.io/)

select for now:
RESTEasy JSON-B
Hibernate Validator

SmallRye JWT
SmallRye OpenAPI

JDBC Driver - H2
Hibernate ORM with Panache


A new WorkFlow for me
``` bash
./mvnw quarkus:dev
```

-> http://0.0.0.0:8080/swagger-ui/


view ExampleResource.java 

    import org.jboss.resteasy.annotations.jaxrs.PathParam;
    @GET
    @Path("/{name}")
    @Produces(MediaType.TEXT_PLAIN)
    public String helloWithName(@PathParam String name) {
        return "hello " + name;
    }
    
-> reload page triggers a recompile


mocked mailer service

``` java
package de.grossjonas.signup;

import javax.enterprise.context.ApplicationScoped;

@ApplicationScoped
class MailerService {

    public void sendMail(String email, String subject, String body){
        System.out.println(String.format("email '%s', subject '%s', body '%s'", email, subject, body));
    }
}
```

RegistrationDTO
``` java
package de.grossjonas.signup;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import java.time.LocalDateTime;
import java.util.Objects;
import java.util.StringJoiner;
import java.util.UUID;

public class RegistrationDTO {
    @NotBlank(message="eMail may not be blank")
    private final String eMail;
    @NotNull
    private final UUID uuid;
    @Past
    private final LocalDateTime created;

    public RegistrationDTO(String eMail, UUID uuid, LocalDateTime created) {
        this.eMail = eMail;
        this.uuid = uuid;
        this.created = created;
    }

    public String geteMail() {
        return eMail;
    }

    public UUID getUuid() {
        return uuid;
    }

    public LocalDateTime getCreated() {
        return created;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RegistrationDTO that = (RegistrationDTO) o;
        return Objects.equals(eMail, that.eMail) &&
                Objects.equals(uuid, that.uuid) &&
                Objects.equals(created, that.created);
    }

    @Override
    public int hashCode() {
        return Objects.hash(eMail, uuid, created);
    }

    @Override
    public String toString() {
        return new StringJoiner(", ", RegistrationDTO.class.getSimpleName() + "[", "]")
                .add("eMail='" + eMail + "'")
                .add("uuid=" + uuid)
                .add("created=" + created)
                .toString();
    }
}
```

JsonWebEncryptionService
``` java
package de.grossjonas.signup;

import org.eclipse.microprofile.config.inject.ConfigProperty;
import org.jose4j.jwa.AlgorithmConstraints;
import org.jose4j.jwe.JsonWebEncryption;
import org.jose4j.jwk.JsonWebKey;
import org.jose4j.lang.JoseException;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

@ApplicationScoped
class JsonWebEncryptionService {
    private JsonWebKey jsonWebKey;
    private String encryptionHeader;
    private String encryptionContent;

    @Inject
    public JsonWebEncryptionService(
            @ConfigProperty(name = "jwt.encryption.privatekey") String jwkAsString,
            @ConfigProperty(name = "jwt.encryption.algorithm.header.identifier") String encryptionHeader,
            @ConfigProperty(name = "jwt.encryption.algorithm.content.identifier") String encryptionContent
    ){
        this.encryptionHeader = encryptionHeader;
        this.encryptionContent = encryptionContent;
        try {
            this.jsonWebKey = JsonWebKey.Factory.newJwk(jwkAsString);
        } catch (JoseException e) {
            throw new RuntimeException(e);
        }
    }

    String encrypt(String text){
        JsonWebEncryption jsonWebEncryption = new JsonWebEncryption();
        jsonWebEncryption.setKey(jsonWebKey.getKey());

        jsonWebEncryption.setAlgorithmHeaderValue(encryptionHeader);
        jsonWebEncryption.setEncryptionMethodHeaderParameter(encryptionContent);

        try {
            String base64 = Base64
                    .getEncoder()
                    .withoutPadding()
                    .encodeToString(text.getBytes(StandardCharsets.UTF_8));

            jsonWebEncryption.setPayload(base64);

            return jsonWebEncryption.getCompactSerialization();

        } catch (JoseException e) {
            throw new RuntimeException(e);
        }
    }

    String decrypt(String jweAsString){
        JsonWebEncryption jsonWebEncryption = new JsonWebEncryption();

        jsonWebEncryption.setAlgorithmConstraints(new AlgorithmConstraints(AlgorithmConstraints.ConstraintType.WHITELIST, encryptionHeader));
        jsonWebEncryption.setContentEncryptionAlgorithmConstraints(new AlgorithmConstraints(AlgorithmConstraints.ConstraintType.WHITELIST, encryptionContent));

        jsonWebEncryption.setKey(jsonWebKey.getKey());

        try {
            jsonWebEncryption.setCompactSerialization(jweAsString);

            String decrypted = jsonWebEncryption.getPayload();

            byte[] decoded = Base64.getDecoder().decode(decrypted);

            return new String(decoded, StandardCharsets.UTF_8);

        } catch (JoseException e) {
            throw new RuntimeException(e);
        }
    }

}
```


Supported Mappings:
for Header:
KeyManagementAlgorithmIdentifiers.A128KW

for Content:
ContentEncryptionAlgorithmIdentifiers.AES_128_CBC_HMAC_SHA_256

``` properties
quarkus.datasource.db-kind=h2
quarkus.datasource.jdbc.url=jdbc:h2:file:./dev.db
quarkus.hibernate-orm.database.generation=drop-and-create
mp.jwt.verify.publickey=asdf
jwt.encryption.privatekey=asasdf
jwt.encryption.algorithm.header.identifier=A256KW
jwt.encryption.algorithm.content.identifier=A128CBC-HS256
```

UserEntity
``` java
package de.grossjonas.signup;

import io.quarkus.hibernate.orm.panache.PanacheEntity;

import javax.persistence.Entity;
import java.time.LocalDateTime;
import java.util.Optional;

@Entity
public class UserEntity extends PanacheEntity {
    public String email;
    public String password;
    public LocalDateTime created;

    public UserEntity() {
        // hibernate
    }

    public UserEntity(String email, String password) {
        this.email = email;
        this.password = password;
        this.created = LocalDateTime.now();
    }

    public static Optional<UserEntity> by(String email, String password){
        return find("email = ?1 and password = ?2", email, password).firstResultOptional();
    }
}
```


SignUp
``` html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>SignUp</title>
</head>
<body>

<form action="signup" method="post">
    <input type="text" name="email" placeholder="your@email.here"/>
    <button type="submit">Submit</button>
</form>

</body>
</html>
```

Password
``` html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Enter your password</title>
    <script>
        document.addEventListener("DOMContentLoaded", event => {
            const search = document.location.search;
            const urlParams = new URLSearchParams(search);

            const uuid = urlParams.get("token");
            document.querySelector("input[name=token]").value = uuid;
        });
    </script>
</head>
<body>

<form action="/password" method="post">
    <input type="hidden" name="token" />
    <input type="text" name="password" placeholder="password" />
    <button type="submit">Submit</button>
</form>

</body>
</html>
```

IE is dead \o/
``` javascript
document.addEventListener("DOMContentLoaded", event => {
            const search = document.location.search;
            const urlParams = new URLSearchParams(search);

            const uuid = urlParams.get("token");
            document.querySelector("input[name=token]").value = uuid;
        });
```

login.html
``` html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
</head>
<body>

<form action="/login" method="post">
    <input type="text" name="email" placeholder="your@email.here" />
    <input type="text" name="password" placeholder="p4ssw0rd"/>
    <button type="submit">Submit</button>
</form>

</body>
</html>
```


Api
``` java
package de.grossjonas.signup;

import javax.inject.Inject;
import javax.json.bind.Jsonb;
import javax.validation.ConstraintViolation;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.net.URI;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.Set;
import java.util.UUID;
import javax.validation.Validator;
import org.jboss.logging.Logger;

@Path("/api")
class ApiResource {

//    private static final Logger LOGGER = Logger.getLogger(ApiResource.class);

    @Inject
    Jsonb jsonb;

//    @Inject
//    Validator validator;

    @Inject
    MailerService mailerService;

    @Inject
    JsonWebEncryptionService jsonWebEncryptionService;

    @POST
    @Path("/signup")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public Response signup(@FormParam("email") String email){

        String registrationAsJson = jsonb.toJson(new RegistrationDTO(
                email,
                UUID.randomUUID(),
                LocalDateTime.now()
        ));

        String token = jsonWebEncryptionService.encrypt(registrationAsJson);

        mailerService.sendMail(
                email,
                "confirm your mail",
                "http://localhost:8080/password?token="+token
        );

        return Response.noContent().build();
    }

    @POST
    @Path("/password")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public Response password(
            @FormParam("token") String token,
            @FormParam("password") String password
    ){
        String registrationAsString = jsonWebEncryptionService.decrypt(token);

        RegistrationDTO registrationDTO = jsonb.fromJson(registrationAsString, RegistrationDTO.class);

//        Set<ConstraintViolation<RegistrationDTO>> constraintViolations = validator.validate(registrationDTO);
//        if(constraintViolations.size() > 0){
//            LOGGER.error(constraintViolations);
//            return Response.status(Response.Status.BAD_REQUEST).build();
//        }

        if(LocalDateTime
                .now()
                .minus(Duration.ofMinutes(10))
                .isAfter(registrationDTO.getCreated())
        ){
            return Response.status(Response.Status.REQUEST_TIMEOUT).build();
        }

        String eMail = registrationDTO.geteMail();

        new UserEntity(eMail, password).persistAndFlush();

        return Response.temporaryRedirect(URI.create("http://localhost:8080/login.html")).build();
    }

    @POST
    @Path("/login")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public Response login(
            @FormParam("email") String email,
            @FormParam("password") String password
    ){
        throw new UnsupportedOperationException("NIY");
    }
}
```


KeyGeneratorUtilTest
``` java
package de.grossjonas.signup;

import org.hamcrest.Matchers;
import org.jose4j.jwk.JsonWebKey;
import org.jose4j.lang.JoseException;
import org.junit.jupiter.api.Test;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;

import static org.hamcrest.MatcherAssert.assertThat;

public class KeyGeneratorUtilTest {
    @Test
    void rsa() throws NoSuchAlgorithmException, JoseException {
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
        keyPairGenerator.initialize(3 * 1024);
        KeyPair keyPair = keyPairGenerator.generateKeyPair();

        JsonWebKey jsonWebKey = JsonWebKey.Factory.newJwk(keyPair.getPublic());
        String jwkAsJsonString = jsonWebKey.toJson();

        // for mp.jwt.verify.publickey=
        assertThat(jwkAsJsonString, Matchers.notNullValue());
    }

    @Test
    void aes() throws NoSuchAlgorithmException, JoseException {
        KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
        keyGenerator.init(256);
        SecretKey secretKey = keyGenerator.generateKey();

        JsonWebKey jsonWebKey = JsonWebKey.Factory.newJwk(secretKey);
        String jwkAsJsonString = jsonWebKey.toJson();

        // for jwt.encryption.privatekey=
        assertThat(jwkAsJsonString, Matchers.notNullValue());
    }
}

```

