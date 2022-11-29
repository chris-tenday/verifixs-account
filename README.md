# Edge web I

## Project setup

```
npm install
```

### Compiles and hot-reloads for development

```
npm run serve
```

### Compiles and minifies for production

```
npm run build
```

### Lints and fixes files

```
npm run lint
```

### Customize configuration

See [Configuration Reference](https://cli.vuejs.org/config/).


### OTP Modal

Ajouter dans votre composant  le ###Modal OTP de la maniere suivant

```
<otp-modal @onSubmitted="$event" @onChanged="$event" />

Emits : - @onSubmitted : retourne la valeur complete du champs otp et lance un evenement.
        - @onChanged : retourne la valeur en cours d'insertion ou de modification.

```
Affichage du Modal OTP se fait de deux manière :
   * Simple appel du modal via les attributs Bootstrap data-target & data-toggle
      Example :

      SCRIPT

            methods:{
                onChanged(value) {
                    console.log(value);
                },
                onSubmitted(value) {
                    console.log(value);
                },
            }

      HTML

            <otp-modal 
                @onChanged="onChanged($event)" 
                @onSubmitted="onSubmitted($event)"
            />
            <a
                href="#"
                data-target="#otpModal"
                data-toggle="modal"
                class="btn btn-primary"
                > Afficher Otp modal 
            </a> 

        
    * Programmatically

       SCRIPT
            methods:{
                onChanged(value) {
                    console.log(value);
                },
                onSubmitted(value) {
                    console.log(value);
                },

                onOpened(){
                    this.$modal('show');
                }
            }


        HTML
            <otp-modal
                @onOpened="onOpened"  
                @onChanged="onChanged($event)" 
                @onSubmitted="onSubmitted($event)"
            />



    



