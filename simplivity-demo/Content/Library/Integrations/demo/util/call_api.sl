namespace: Integrations.demo.util
flow:
  name: call_api
  inputs:
    - OVC_IP: 10.41.37.91
    - api_name: /api/virtual_machines
    - api_url:
        default: "${'https://' + OVC_IP + api_name}"
        private: true
        required: false
    - vCenterAdminName: administrator@vsphere.local
    - vCenterAdminPasswd:
        default: P@ssw0rd
        sensitive: true
    - api_param:
        required: false
    - api_method: POST
  workflow:
    - get_token:
        do:
          Integrations.demo.util.get_token: []
        publish:
          - token
        navigate:
          - FAILURE: on_failure
          - SUCCESS: http_client_action
    - http_client_action:
        do:
          io.cloudslang.base.http.http_client_action:
            - url: '${api_url}'
            - auth_type: anonymous
            - preemptive_auth: 'false'
            - headers: '${"Authorization: Bearer " + token}'
            - body: '${api_param}'
            - content_type: application/vnd.simplivity.v1.9+json
            - method: '${api_method}'
        publish:
          - return_result
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  outputs:
    - result: '${return_result}'
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      http_client_action:
        x: 311
        y: 161
        navigate:
          42575f99-5e20-53dd-a2fc-b02a8a65fcbc:
            targetId: 4eea6961-b2f8-eb11-ab9e-a3c04f8f70b4
            port: SUCCESS
      get_token:
        x: 109
        y: 159
    results:
      SUCCESS:
        4eea6961-b2f8-eb11-ab9e-a3c04f8f70b4:
          x: 576
          y: 144
