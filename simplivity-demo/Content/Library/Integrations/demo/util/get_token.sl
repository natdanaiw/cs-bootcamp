namespace: Integrations.demo.util
flow:
  name: get_token
  inputs:
    - OVC_IP: 10.41.37.91
    - vCenterAdminName: administrator@vsphere.local
    - vCenterAdminPasswd:
        default: P@ssw0rd
        sensitive: false
    - auth_url:
        default: "${'https://' + OVC_IP + '/api/oauth/token'}"
        private: true
  workflow:
    - http_client_action:
        do:
          io.cloudslang.base.http.http_client_action:
            - url: '${auth_url}'
            - auth_type: basic
            - username: simplivity
            - password:
                value: ''
                sensitive: true
            - trust_all_roots: 'true'
            - x_509_hostname_verifier: allow_all
            - headers: 'Accept:application/json'
            - response_character_set: utf8
            - request_character_set: utf8
            - multipart_bodies: "${'username='+ vCenterAdminName+'&password='+ vCenterAdminPasswd+'&grant_type=password'}"
            - multipart_bodies_content_type: text/plain
            - method: POST
        publish:
          - result: '${return_result}'
        navigate:
          - SUCCESS: get_access_token_value
          - FAILURE: on_failure
    - get_access_token_value:
        do:
          io.cloudslang.base.json.json_path_query:
            - json_object: '${result}'
            - json_path: $.access_token
        publish:
          - return_token: '${return_result}'
        navigate:
          - SUCCESS: search_and_replace
          - FAILURE: on_failure
    - search_and_replace:
        do:
          io.cloudslang.base.strings.search_and_replace:
            - origin_string: '${return_token}'
            - text_to_replace: '"'
            - replace_with: ''
        publish:
          - replaced_string
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
    - on_failure:
        - json_path_query:
            do:
              io.cloudslang.base.json.json_path_query:
                - json_object: '${result}'
                - json_path: $.exception
            publish:
              - return_result
  outputs:
    - token: '${replaced_string}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      http_client_action:
        x: 214
        y: 146
      get_access_token_value:
        x: 373
        y: 146
      search_and_replace:
        x: 506
        y: 149
        navigate:
          b93ae12e-c7f4-219e-8c76-1fbeb2b9f45a:
            targetId: add20190-b885-7695-a287-2cc6e3b97d18
            port: SUCCESS
    results:
      SUCCESS:
        add20190-b885-7695-a287-2cc6e3b97d18:
          x: 662
          y: 81
