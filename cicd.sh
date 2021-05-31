
#!/bin/bash

cat <<EOF >> argocd.yaml
# This is an auto-generated file. DO NOT EDIT
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  labels:
    app.kubernetes.io/name: applications.argoproj.io
    app.kubernetes.io/part-of: argocd
  name: applications.argoproj.io
spec:
  group: argoproj.io
  names:
    kind: Application
    listKind: ApplicationList
    plural: applications
    shortNames:
    - app
    - apps
    singular: application
  scope: Namespaced
  versions:
  - additionalPrinterColumns:
    - jsonPath: .status.sync.status
      name: Sync Status
      type: string
    - jsonPath: .status.health.status
      name: Health Status
      type: string
    - jsonPath: .status.sync.revision
      name: Revision
      priority: 10
      type: string
    name: v1alpha1
    schema:
      openAPIV3Schema:
        description: Application is a definition of Application resource.
        properties:
          apiVersion:
            description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
            type: string
          kind:
            description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
            type: string
          metadata:
            type: object
          operation:
            description: Operation contains information about a requested or running operation
            properties:
              info:
                description: Info is a list of informational items for this operation
                items:
                  properties:
                    name:
                      type: string
                    value:
                      type: string
                  required:
                  - name
                  - value
                  type: object
                type: array
              initiatedBy:
                description: InitiatedBy contains information about who initiated the operations
                properties:
                  automated:
                    description: Automated is set to true if operation was initiated automatically by the application controller.
                    type: boolean
                  username:
                    description: Username contains the name of a user who started operation
                    type: string
                type: object
              retry:
                description: Retry controls the strategy to apply if a sync fails
                properties:
                  backoff:
                    description: Backoff controls how to backoff on subsequent retries of failed syncs
                    properties:
                      duration:
                        description: Duration is the amount to back off. Default unit is seconds, but could also be a duration (e.g. "2m", "1h")
                        type: string
                      factor:
                        description: Factor is a factor to multiply the base duration after each failed retry
                        format: int64
                        type: integer
                      maxDuration:
                        description: MaxDuration is the maximum amount of time allowed for the backoff strategy
                        type: string
                    type: object
                  limit:
                    description: Limit is the maximum number of attempts for retrying a failed sync. If set to 0, no retries will be performed.
                    format: int64
                    type: integer
                type: object
              sync:
                description: Sync contains parameters for the operation
                properties:
                  dryRun:
                    description: DryRun specifies to perform a `kubectl apply --dry-run` without actually performing the sync
                    type: boolean
                  manifests:
                    description: Manifests is an optional field that overrides sync source with a local directory for development
                    items:
                      type: string
                    type: array
                  prune:
                    description: Prune specifies to delete resources from the cluster that are no longer tracked in git
                    type: boolean
                  resources:
                    description: Resources describes which resources shall be part of the sync
                    items:
                      description: SyncOperationResource contains resources to sync.
                      properties:
                        group:
                          type: string
                        kind:
                          type: string
                        name:
                          type: string
                        namespace:
                          type: string
                      required:
                      - kind
                      - name
                      type: object
                    type: array
                  revision:
                    description: Revision is the revision (Git) or chart version (Helm) which to sync the application to If omitted, will use the revision specified in app spec.
                    type: string
                  source:
                    description: Source overrides the source definition set in the application. This is typically set in a Rollback operation and is nil during a Sync operation
                    properties:
                      chart:
                        description: Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
                        type: string
                      directory:
                        description: Directory holds path/directory specific options
                        properties:
                          exclude:
                            description: Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
                            type: string
                          include:
                            description: Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
                            type: string
                          jsonnet:
                            description: Jsonnet holds options specific to Jsonnet
                            properties:
                              extVars:
                                description: ExtVars is a list of Jsonnet External Variables
                                items:
                                  description: JsonnetVar represents a variable to be passed to jsonnet during manifest generation
                                  properties:
                                    code:
                                      type: boolean
                                    name:
                                      type: string
                                    value:
                                      type: string
                                  required:
                                  - name
                                  - value
                                  type: object
                                type: array
                              libs:
                                description: Additional library search dirs
                                items:
                                  type: string
                                type: array
                              tlas:
                                description: TLAS is a list of Jsonnet Top-level Arguments
                                items:
                                  description: JsonnetVar represents a variable to be passed to jsonnet during manifest generation
                                  properties:
                                    code:
                                      type: boolean
                                    name:
                                      type: string
                                    value:
                                      type: string
                                  required:
                                  - name
                                  - value
                                  type: object
                                type: array
                            type: object
                          recurse:
                            description: Recurse specifies whether to scan a directory recursively for manifests
                            type: boolean
                        type: object
                      helm:
                        description: Helm holds helm specific options
                        properties:
                          fileParameters:
                            description: FileParameters are file parameters to the helm template
                            items:
                              description: HelmFileParameter is a file parameter that's passed to helm template during manifest generation
                              properties:
                                name:
                                  description: Name is the name of the Helm parameter
                                  type: string
                                path:
                                  description: Path is the path to the file containing the values for the Helm parameter
                                  type: string
                              type: object
                            type: array
                          parameters:
                            description: Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
                            items:
                              description: HelmParameter is a parameter that's passed to helm template during manifest generation
                              properties:
                                forceString:
                                  description: ForceString determines whether to tell Helm to interpret booleans and numbers as strings
                                  type: boolean
                                name:
                                  description: Name is the name of the Helm parameter
                                  type: string
                                value:
                                  description: Value is the value for the Helm parameter
                                  type: string
                              type: object
                            type: array
                          releaseName:
                            description: ReleaseName is the Helm release name to use. If omitted it will use the application name
                            type: string
                          valueFiles:
                            description: ValuesFiles is a list of Helm value files to use when generating a template
                            items:
                              type: string
                            type: array
                          values:
                            description: Values specifies Helm values to be passed to helm template, typically defined as a block
                            type: string
                          version:
                            description: Version is the Helm version to use for templating (either "2" or "3")
                            type: string
                        type: object
                      ksonnet:
                        description: Ksonnet holds ksonnet specific options
                        properties:
                          environment:
                            description: Environment is a ksonnet application environment name
                            type: string
                          parameters:
                            description: Parameters are a list of ksonnet component parameter override values
                            items:
                              description: KsonnetParameter is a ksonnet component parameter
                              properties:
                                component:
                                  type: string
                                name:
                                  type: string
                                value:
                                  type: string
                              required:
                              - name
                              - value
                              type: object
                            type: array
                        type: object
                      kustomize:
                        description: Kustomize holds kustomize specific options
                        properties:
                          commonAnnotations:
                            additionalProperties:
                              type: string
                            description: CommonAnnotations is a list of additional annotations to add to rendered manifests
                            type: object
                          commonLabels:
                            additionalProperties:
                              type: string
                            description: CommonLabels is a list of additional labels to add to rendered manifests
                            type: object
                          images:
                            description: Images is a list of Kustomize image override specifications
                            items:
                              description: KustomizeImage represents a Kustomize image definition in the format [old_image_name=]<image_name>:<image_tag>
                              type: string
                            type: array
                          namePrefix:
                            description: NamePrefix is a prefix appended to resources for Kustomize apps
                            type: string
                          nameSuffix:
                            description: NameSuffix is a suffix appended to resources for Kustomize apps
                            type: string
                          version:
                            description: Version controls which version of Kustomize to use for rendering manifests
                            type: string
                        type: object
                      path:
                        description: Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
                        type: string
                      plugin:
                        description: ConfigManagementPlugin holds config management plugin specific options
                        properties:
                          env:
                            description: Env is a list of environment variable entries
                            items:
                              description: EnvEntry represents an entry in the application's environment
                              properties:
                                name:
                                  description: Name is the name of the variable, usually expressed in uppercase
                                  type: string
                                value:
                                  description: Value is the value of the variable
                                  type: string
                              required:
                              - name
                              - value
                              type: object
                            type: array
                          name:
                            type: string
                        type: object
                      repoURL:
                        description: RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
                        type: string
                      targetRevision:
                        description: TargetRevision defines the revision of the source to sync the application to. In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD. In case of Helm, this is a semver tag for the Chart's version.
                        type: string
                    required:
                    - repoURL
                    type: object
                  syncOptions:
                    description: SyncOptions provide per-sync sync-options, e.g. Validate=false
                    items:
                      type: string
                    type: array
                  syncStrategy:
                    description: SyncStrategy describes how to perform the sync
                    properties:
                      apply:
                        description: Apply will perform a `kubectl apply` to perform the sync.
                        properties:
                          force:
                            description: Force indicates whether or not to supply the --force flag to `kubectl apply`. The --force flag deletes and re-create the resource, when PATCH encounters conflict and has retried for 5 times.
                            type: boolean
                        type: object
                      hook:
                        description: Hook will submit any referenced resources to perform the sync. This is the default strategy
                        properties:
                          force:
                            description: Force indicates whether or not to supply the --force flag to `kubectl apply`. The --force flag deletes and re-create the resource, when PATCH encounters conflict and has retried for 5 times.
                            type: boolean
                        type: object
                    type: object
                type: object
            type: object
          spec:
            description: ApplicationSpec represents desired application state. Contains link to repository with application definition and additional parameters link definition revision.
            properties:
              destination:
                description: Destination is a reference to the target Kubernetes server and namespace
                properties:
                  name:
                    description: Name is an alternate way of specifying the target cluster by its symbolic name
                    type: string
                  namespace:
                    description: Namespace specifies the target namespace for the application's resources. The namespace will only be set for namespace-scoped resources that have not set a value for .metadata.namespace
                    type: string
                  server:
                    description: Server specifies the URL of the target cluster and must be set to the Kubernetes control plane API
                    type: string
                type: object
              ignoreDifferences:
                description: IgnoreDifferences is a list of resources and their fields which should be ignored during comparison
                items:
                  description: ResourceIgnoreDifferences contains resource filter and list of json paths which should be ignored during comparison with live state.
                  properties:
                    group:
                      type: string
                    jsonPointers:
                      items:
                        type: string
                      type: array
                    kind:
                      type: string
                    name:
                      type: string
                    namespace:
                      type: string
                  required:
                  - jsonPointers
                  - kind
                  type: object
                type: array
              info:
                description: Info contains a list of information (URLs, email addresses, and plain text) that relates to the application
                items:
                  properties:
                    name:
                      type: string
                    value:
                      type: string
                  required:
                  - name
                  - value
                  type: object
                type: array
              project:
                description: Project is a reference to the project this application belongs to. The empty string means that application belongs to the 'default' project.
                type: string
              revisionHistoryLimit:
                description: RevisionHistoryLimit limits the number of items kept in the application's revision history, which is used for informational purposes as well as for rollbacks to previous versions. This should only be changed in exceptional circumstances. Setting to zero will store no history. This will reduce storage used. Increasing will increase the space used to store the history, so we do not recommend increasing it. Default is 10.
                format: int64
                type: integer
              source:
                description: Source is a reference to the location of the application's manifests or chart
                properties:
                  chart:
                    description: Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
                    type: string
                  directory:
                    description: Directory holds path/directory specific options
                    properties:
                      exclude:
                        description: Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
                        type: string
                      include:
                        description: Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
                        type: string
                      jsonnet:
                        description: Jsonnet holds options specific to Jsonnet
                        properties:
                          extVars:
                            description: ExtVars is a list of Jsonnet External Variables
                            items:
                              description: JsonnetVar represents a variable to be passed to jsonnet during manifest generation
                              properties:
                                code:
                                  type: boolean
                                name:
                                  type: string
                                value:
                                  type: string
                              required:
                              - name
                              - value
                              type: object
                            type: array
                          libs:
                            description: Additional library search dirs
                            items:
                              type: string
                            type: array
                          tlas:
                            description: TLAS is a list of Jsonnet Top-level Arguments
                            items:
                              description: JsonnetVar represents a variable to be passed to jsonnet during manifest generation
                              properties:
                                code:
                                  type: boolean
                                name:
                                  type: string
                                value:
                                  type: string
                              required:
                              - name
                              - value
                              type: object
                            type: array
                        type: object
                      recurse:
                        description: Recurse specifies whether to scan a directory recursively for manifests
                        type: boolean
                    type: object
                  helm:
                    description: Helm holds helm specific options
                    properties:
                      fileParameters:
                        description: FileParameters are file parameters to the helm template
                        items:
                          description: HelmFileParameter is a file parameter that's passed to helm template during manifest generation
                          properties:
                            name:
                              description: Name is the name of the Helm parameter
                              type: string
                            path:
                              description: Path is the path to the file containing the values for the Helm parameter
                              type: string
                          type: object
                        type: array
                      parameters:
                        description: Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
                        items:
                          description: HelmParameter is a parameter that's passed to helm template during manifest generation
                          properties:
                            forceString:
                              description: ForceString determines whether to tell Helm to interpret booleans and numbers as strings
                              type: boolean
                            name:
                              description: Name is the name of the Helm parameter
                              type: string
                            value:
                              description: Value is the value for the Helm parameter
                              type: string
                          type: object
                        type: array
                      releaseName:
                        description: ReleaseName is the Helm release name to use. If omitted it will use the application name
                        type: string
                      valueFiles:
                        description: ValuesFiles is a list of Helm value files to use when generating a template
                        items:
                          type: string
                        type: array
                      values:
                        description: Values specifies Helm values to be passed to helm template, typically defined as a block
                        type: string
                      version:
                        description: Version is the Helm version to use for templating (either "2" or "3")
                        type: string
                    type: object
                  ksonnet:
                    description: Ksonnet holds ksonnet specific options
                    properties:
                      environment:
                        description: Environment is a ksonnet application environment name
                        type: string
                      parameters:
                        description: Parameters are a list of ksonnet component parameter override values
                        items:
                          description: KsonnetParameter is a ksonnet component parameter
                          properties:
                            component:
                              type: string
                            name:
                              type: string
                            value:
                              type: string
                          required:
                          - name
                          - value
                          type: object
                        type: array
                    type: object
                  kustomize:
                    description: Kustomize holds kustomize specific options
                    properties:
                      commonAnnotations:
                        additionalProperties:
                          type: string
                        description: CommonAnnotations is a list of additional annotations to add to rendered manifests
                        type: object
                      commonLabels:
                        additionalProperties:
                          type: string
                        description: CommonLabels is a list of additional labels to add to rendered manifests
                        type: object
                      images:
                        description: Images is a list of Kustomize image override specifications
                        items:
                          description: KustomizeImage represents a Kustomize image definition in the format [old_image_name=]<image_name>:<image_tag>
                          type: string
                        type: array
                      namePrefix:
                        description: NamePrefix is a prefix appended to resources for Kustomize apps
                        type: string
                      nameSuffix:
                        description: NameSuffix is a suffix appended to resources for Kustomize apps
                        type: string
                      version:
                        description: Version controls which version of Kustomize to use for rendering manifests
                        type: string
                    type: object
                  path:
                    description: Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
                    type: string
                  plugin:
                    description: ConfigManagementPlugin holds config management plugin specific options
                    properties:
                      env:
                        description: Env is a list of environment variable entries
                        items:
                          description: EnvEntry represents an entry in the application's environment
                          properties:
                            name:
                              description: Name is the name of the variable, usually expressed in uppercase
                              type: string
                            value:
                              description: Value is the value of the variable
                              type: string
                          required:
                          - name
                          - value
                          type: object
                        type: array
                      name:
                        type: string
                    type: object
                  repoURL:
                    description: RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
                    type: string
                  targetRevision:
                    description: TargetRevision defines the revision of the source to sync the application to. In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD. In case of Helm, this is a semver tag for the Chart's version.
                    type: string
                required:
                - repoURL
                type: object
              syncPolicy:
                description: SyncPolicy controls when and how a sync will be performed
                properties:
                  automated:
                    description: Automated will keep an application synced to the target revision
                    properties:
                      allowEmpty:
                        description: 'AllowEmpty allows apps have zero live resources (default: false)'
                        type: boolean
                      prune:
                        description: 'Prune specifies whether to delete resources from the cluster that are not found in the sources anymore as part of automated sync (default: false)'
                        type: boolean
                      selfHeal:
                        description: 'SelfHeal specifes whether to revert resources back to their desired state upon modification in the cluster (default: false)'
                        type: boolean
                    type: object
                  retry:
                    description: Retry controls failed sync retry behavior
                    properties:
                      backoff:
                        description: Backoff controls how to backoff on subsequent retries of failed syncs
                        properties:
                          duration:
                            description: Duration is the amount to back off. Default unit is seconds, but could also be a duration (e.g. "2m", "1h")
                            type: string
                          factor:
                            description: Factor is a factor to multiply the base duration after each failed retry
                            format: int64
                            type: integer
                          maxDuration:
                            description: MaxDuration is the maximum amount of time allowed for the backoff strategy
                            type: string
                        type: object
                      limit:
                        description: Limit is the maximum number of attempts for retrying a failed sync. If set to 0, no retries will be performed.
                        format: int64
                        type: integer
                    type: object
                  syncOptions:
                    description: Options allow you to specify whole app sync-options
                    items:
                      type: string
                    type: array
                type: object
            required:
            - destination
            - project
            - source
            type: object
          status:
            description: ApplicationStatus contains status information for the application
            properties:
              conditions:
                description: Conditions is a list of currently observed application conditions
                items:
                  description: ApplicationCondition contains details about an application condition, which is usally an error or warning
                  properties:
                    lastTransitionTime:
                      description: LastTransitionTime is the time the condition was last observed
                      format: date-time
                      type: string
                    message:
                      description: Message contains human-readable message indicating details about condition
                      type: string
                    type:
                      description: Type is an application condition type
                      type: string
                  required:
                  - message
                  - type
                  type: object
                type: array
              health:
                description: Health contains information about the application's current health status
                properties:
                  message:
                    description: Message is a human-readable informational message describing the health status
                    type: string
                  status:
                    description: Status holds the status code of the application or resource
                    type: string
                type: object
              history:
                description: History contains information about the application's sync history
                items:
                  description: RevisionHistory contains history information about a previous sync
                  properties:
                    deployStartedAt:
                      description: DeployStartedAt holds the time the sync operation started
                      format: date-time
                      type: string
                    deployedAt:
                      description: DeployedAt holds the time the sync operation completed
                      format: date-time
                      type: string
                    id:
                      description: ID is an auto incrementing identifier of the RevisionHistory
                      format: int64
                      type: integer
                    revision:
                      description: Revision holds the revision the sync was performed against
                      type: string
                    source:
                      description: Source is a reference to the application source used for the sync operation
                      properties:
                        chart:
                          description: Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
                          type: string
                        directory:
                          description: Directory holds path/directory specific options
                          properties:
                            exclude:
                              description: Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
                              type: string
                            include:
                              description: Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
                              type: string
                            jsonnet:
                              description: Jsonnet holds options specific to Jsonnet
                              properties:
                                extVars:
                                  description: ExtVars is a list of Jsonnet External Variables
                                  items:
                                    description: JsonnetVar represents a variable to be passed to jsonnet during manifest generation
                                    properties:
                                      code:
                                        type: boolean
                                      name:
                                        type: string
                                      value:
                                        type: string
                                    required:
                                    - name
                                    - value
                                    type: object
                                  type: array
                                libs:
                                  description: Additional library search dirs
                                  items:
                                    type: string
                                  type: array
                                tlas:
                                  description: TLAS is a list of Jsonnet Top-level Arguments
                                  items:
                                    description: JsonnetVar represents a variable to be passed to jsonnet during manifest generation
                                    properties:
                                      code:
                                        type: boolean
                                      name:
                                        type: string
                                      value:
                                        type: string
                                    required:
                                    - name
                                    - value
                                    type: object
                                  type: array
                              type: object
                            recurse:
                              description: Recurse specifies whether to scan a directory recursively for manifests
                              type: boolean
                          type: object
                        helm:
                          description: Helm holds helm specific options
                          properties:
                            fileParameters:
                              description: FileParameters are file parameters to the helm template
                              items:
                                description: HelmFileParameter is a file parameter that's passed to helm template during manifest generation
                                properties:
                                  name:
                                    description: Name is the name of the Helm parameter
                                    type: string
                                  path:
                                    description: Path is the path to the file containing the values for the Helm parameter
                                    type: string
                                type: object
                              type: array
                            parameters:
                              description: Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
                              items:
                                description: HelmParameter is a parameter that's passed to helm template during manifest generation
                                properties:
                                  forceString:
                                    description: ForceString determines whether to tell Helm to interpret booleans and numbers as strings
                                    type: boolean
                                  name:
                                    description: Name is the name of the Helm parameter
                                    type: string
                                  value:
                                    description: Value is the value for the Helm parameter
                                    type: string
                                type: object
                              type: array
                            releaseName:
                              description: ReleaseName is the Helm release name to use. If omitted it will use the application name
                              type: string
                            valueFiles:
                              description: ValuesFiles is a list of Helm value files to use when generating a template
                              items:
                                type: string
                              type: array
                            values:
                              description: Values specifies Helm values to be passed to helm template, typically defined as a block
                              type: string
                            version:
                              description: Version is the Helm version to use for templating (either "2" or "3")
                              type: string
                          type: object
                        ksonnet:
                          description: Ksonnet holds ksonnet specific options
                          properties:
                            environment:
                              description: Environment is a ksonnet application environment name
                              type: string
                            parameters:
                              description: Parameters are a list of ksonnet component parameter override values
                              items:
                                description: KsonnetParameter is a ksonnet component parameter
                                properties:
                                  component:
                                    type: string
                                  name:
                                    type: string
                                  value:
                                    type: string
                                required:
                                - name
                                - value
                                type: object
                              type: array
                          type: object
                        kustomize:
                          description: Kustomize holds kustomize specific options
                          properties:
                            commonAnnotations:
                              additionalProperties:
                                type: string
                              description: CommonAnnotations is a list of additional annotations to add to rendered manifests
                              type: object
                            commonLabels:
                              additionalProperties:
                                type: string
                              description: CommonLabels is a list of additional labels to add to rendered manifests
                              type: object
                            images:
                              description: Images is a list of Kustomize image override specifications
                              items:
                                description: KustomizeImage represents a Kustomize image definition in the format [old_image_name=]<image_name>:<image_tag>
                                type: string
                              type: array
                            namePrefix:
                              description: NamePrefix is a prefix appended to resources for Kustomize apps
                              type: string
                            nameSuffix:
                              description: NameSuffix is a suffix appended to resources for Kustomize apps
                              type: string
                            version:
                              description: Version controls which version of Kustomize to use for rendering manifests
                              type: string
                          type: object
                        path:
                          description: Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
                          type: string
                        plugin:
                          description: ConfigManagementPlugin holds config management plugin specific options
                          properties:
                            env:
                              description: Env is a list of environment variable entries
                              items:
                                description: EnvEntry represents an entry in the application's environment
                                properties:
                                  name:
                                    description: Name is the name of the variable, usually expressed in uppercase
                                    type: string
                                  value:
                                    description: Value is the value of the variable
                                    type: string
                                required:
                                - name
                                - value
                                type: object
                              type: array
                            name:
                              type: string
                          type: object
                        repoURL:
                          description: RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
                          type: string
                        targetRevision:
                          description: TargetRevision defines the revision of the source to sync the application to. In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD. In case of Helm, this is a semver tag for the Chart's version.
                          type: string
                      required:
                      - repoURL
                      type: object
                  required:
                  - deployedAt
                  - id
                  - revision
                  type: object
                type: array
              observedAt:
                description: 'ObservedAt indicates when the application state was updated without querying latest git state Deprecated: controller no longer updates ObservedAt field'
                format: date-time
                type: string
              operationState:
                description: OperationState contains information about any ongoing operations, such as a sync
                properties:
                  finishedAt:
                    description: FinishedAt contains time of operation completion
                    format: date-time
                    type: string
                  message:
                    description: Message holds any pertinent messages when attempting to perform operation (typically errors).
                    type: string
                  operation:
                    description: Operation is the original requested operation
                    properties:
                      info:
                        description: Info is a list of informational items for this operation
                        items:
                          properties:
                            name:
                              type: string
                            value:
                              type: string
                          required:
                          - name
                          - value
                          type: object
                        type: array
                      initiatedBy:
                        description: InitiatedBy contains information about who initiated the operations
                        properties:
                          automated:
                            description: Automated is set to true if operation was initiated automatically by the application controller.
                            type: boolean
                          username:
                            description: Username contains the name of a user who started operation
                            type: string
                        type: object
                      retry:
                        description: Retry controls the strategy to apply if a sync fails
                        properties:
                          backoff:
                            description: Backoff controls how to backoff on subsequent retries of failed syncs
                            properties:
                              duration:
                                description: Duration is the amount to back off. Default unit is seconds, but could also be a duration (e.g. "2m", "1h")
                                type: string
                              factor:
                                description: Factor is a factor to multiply the base duration after each failed retry
                                format: int64
                                type: integer
                              maxDuration:
                                description: MaxDuration is the maximum amount of time allowed for the backoff strategy
                                type: string
                            type: object
                          limit:
                            description: Limit is the maximum number of attempts for retrying a failed sync. If set to 0, no retries will be performed.
                            format: int64
                            type: integer
                        type: object
                      sync:
                        description: Sync contains parameters for the operation
                        properties:
                          dryRun:
                            description: DryRun specifies to perform a `kubectl apply --dry-run` without actually performing the sync
                            type: boolean
                          manifests:
                            description: Manifests is an optional field that overrides sync source with a local directory for development
                            items:
                              type: string
                            type: array
                          prune:
                            description: Prune specifies to delete resources from the cluster that are no longer tracked in git
                            type: boolean
                          resources:
                            description: Resources describes which resources shall be part of the sync
                            items:
                              description: SyncOperationResource contains resources to sync.
                              properties:
                                group:
                                  type: string
                                kind:
                                  type: string
                                name:
                                  type: string
                                namespace:
                                  type: string
                              required:
                              - kind
                              - name
                              type: object
                            type: array
                          revision:
                            description: Revision is the revision (Git) or chart version (Helm) which to sync the application to If omitted, will use the revision specified in app spec.
                            type: string
                          source:
                            description: Source overrides the source definition set in the application. This is typically set in a Rollback operation and is nil during a Sync operation
                            properties:
                              chart:
                                description: Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
                                type: string
                              directory:
                                description: Directory holds path/directory specific options
                                properties:
                                  exclude:
                                    description: Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
                                    type: string
                                  include:
                                    description: Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
                                    type: string
                                  jsonnet:
                                    description: Jsonnet holds options specific to Jsonnet
                                    properties:
                                      extVars:
                                        description: ExtVars is a list of Jsonnet External Variables
                                        items:
                                          description: JsonnetVar represents a variable to be passed to jsonnet during manifest generation
                                          properties:
                                            code:
                                              type: boolean
                                            name:
                                              type: string
                                            value:
                                              type: string
                                          required:
                                          - name
                                          - value
                                          type: object
                                        type: array
                                      libs:
                                        description: Additional library search dirs
                                        items:
                                          type: string
                                        type: array
                                      tlas:
                                        description: TLAS is a list of Jsonnet Top-level Arguments
                                        items:
                                          description: JsonnetVar represents a variable to be passed to jsonnet during manifest generation
                                          properties:
                                            code:
                                              type: boolean
                                            name:
                                              type: string
                                            value:
                                              type: string
                                          required:
                                          - name
                                          - value
                                          type: object
                                        type: array
                                    type: object
                                  recurse:
                                    description: Recurse specifies whether to scan a directory recursively for manifests
                                    type: boolean
                                type: object
                              helm:
                                description: Helm holds helm specific options
                                properties:
                                  fileParameters:
                                    description: FileParameters are file parameters to the helm template
                                    items:
                                      description: HelmFileParameter is a file parameter that's passed to helm template during manifest generation
                                      properties:
                                        name:
                                          description: Name is the name of the Helm parameter
                                          type: string
                                        path:
                                          description: Path is the path to the file containing the values for the Helm parameter
                                          type: string
                                      type: object
                                    type: array
                                  parameters:
                                    description: Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
                                    items:
                                      description: HelmParameter is a parameter that's passed to helm template during manifest generation
                                      properties:
                                        forceString:
                                          description: ForceString determines whether to tell Helm to interpret booleans and numbers as strings
                                          type: boolean
                                        name:
                                          description: Name is the name of the Helm parameter
                                          type: string
                                        value:
                                          description: Value is the value for the Helm parameter
                                          type: string
                                      type: object
                                    type: array
                                  releaseName:
                                    description: ReleaseName is the Helm release name to use. If omitted it will use the application name
                                    type: string
                                  valueFiles:
                                    description: ValuesFiles is a list of Helm value files to use when generating a template
                                    items:
                                      type: string
                                    type: array
                                  values:
                                    description: Values specifies Helm values to be passed to helm template, typically defined as a block
                                    type: string
                                  version:
                                    description: Version is the Helm version to use for templating (either "2" or "3")
                                    type: string
                                type: object
                              ksonnet:
                                description: Ksonnet holds ksonnet specific options
                                properties:
                                  environment:
                                    description: Environment is a ksonnet application environment name
                                    type: string
                                  parameters:
                                    description: Parameters are a list of ksonnet component parameter override values
                                    items:
                                      description: KsonnetParameter is a ksonnet component parameter
                                      properties:
                                        component:
                                          type: string
                                        name:
                                          type: string
                                        value:
                                          type: string
                                      required:
                                      - name
                                      - value
                                      type: object
                                    type: array
                                type: object
                              kustomize:
                                description: Kustomize holds kustomize specific options
                                properties:
                                  commonAnnotations:
                                    additionalProperties:
                                      type: string
                                    description: CommonAnnotations is a list of additional annotations to add to rendered manifests
                                    type: object
                                  commonLabels:
                                    additionalProperties:
                                      type: string
                                    description: CommonLabels is a list of additional labels to add to rendered manifests
                                    type: object
                                  images:
                                    description: Images is a list of Kustomize image override specifications
                                    items:
                                      description: KustomizeImage represents a Kustomize image definition in the format [old_image_name=]<image_name>:<image_tag>
                                      type: string
                                    type: array
                                  namePrefix:
                                    description: NamePrefix is a prefix appended to resources for Kustomize apps
                                    type: string
                                  nameSuffix:
                                    description: NameSuffix is a suffix appended to resources for Kustomize apps
                                    type: string
                                  version:
                                    description: Version controls which version of Kustomize to use for rendering manifests
                                    type: string
                                type: object
                              path:
                                description: Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
                                type: string
                              plugin:
                                description: ConfigManagementPlugin holds config management plugin specific options
                                properties:
                                  env:
                                    description: Env is a list of environment variable entries
                                    items:
                                      description: EnvEntry represents an entry in the application's environment
                                      properties:
                                        name:
                                          description: Name is the name of the variable, usually expressed in uppercase
                                          type: string
                                        value:
                                          description: Value is the value of the variable
                                          type: string
                                      required:
                                      - name
                                      - value
                                      type: object
                                    type: array
                                  name:
                                    type: string
                                type: object
                              repoURL:
                                description: RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
                                type: string
                              targetRevision:
                                description: TargetRevision defines the revision of the source to sync the application to. In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD. In case of Helm, this is a semver tag for the Chart's version.
                                type: string
                            required:
                            - repoURL
                            type: object
                          syncOptions:
                            description: SyncOptions provide per-sync sync-options, e.g. Validate=false
                            items:
                              type: string
                            type: array
                          syncStrategy:
                            description: SyncStrategy describes how to perform the sync
                            properties:
                              apply:
                                description: Apply will perform a `kubectl apply` to perform the sync.
                                properties:
                                  force:
                                    description: Force indicates whether or not to supply the --force flag to `kubectl apply`. The --force flag deletes and re-create the resource, when PATCH encounters conflict and has retried for 5 times.
                                    type: boolean
                                type: object
                              hook:
                                description: Hook will submit any referenced resources to perform the sync. This is the default strategy
                                properties:
                                  force:
                                    description: Force indicates whether or not to supply the --force flag to `kubectl apply`. The --force flag deletes and re-create the resource, when PATCH encounters conflict and has retried for 5 times.
                                    type: boolean
                                type: object
                            type: object
                        type: object
                    type: object
                  phase:
                    description: Phase is the current phase of the operation
                    type: string
                  retryCount:
                    description: RetryCount contains time of operation retries
                    format: int64
                    type: integer
                  startedAt:
                    description: StartedAt contains time of operation start
                    format: date-time
                    type: string
                  syncResult:
                    description: SyncResult is the result of a Sync operation
                    properties:
                      resources:
                        description: Resources contains a list of sync result items for each individual resource in a sync operation
                        items:
                          description: ResourceResult holds the operation result details of a specific resource
                          properties:
                            group:
                              description: Group specifies the API group of the resource
                              type: string
                            hookPhase:
                              description: HookPhase contains the state of any operation associated with this resource OR hook This can also contain values for non-hook resources.
                              type: string
                            hookType:
                              description: HookType specifies the type of the hook. Empty for non-hook resources
                              type: string
                            kind:
                              description: Kind specifies the API kind of the resource
                              type: string
                            message:
                              description: Message contains an informational or error message for the last sync OR operation
                              type: string
                            name:
                              description: Name specifies the name of the resource
                              type: string
                            namespace:
                              description: Namespace specifies the target namespace of the resource
                              type: string
                            status:
                              description: Status holds the final result of the sync. Will be empty if the resources is yet to be applied/pruned and is always zero-value for hooks
                              type: string
                            syncPhase:
                              description: SyncPhase indicates the particular phase of the sync that this result was acquired in
                              type: string
                            version:
                              description: Version specifies the API version of the resource
                              type: string
                          required:
                          - group
                          - kind
                          - name
                          - namespace
                          - version
                          type: object
                        type: array
                      revision:
                        description: Revision holds the revision this sync operation was performed to
                        type: string
                      source:
                        description: Source records the application source information of the sync, used for comparing auto-sync
                        properties:
                          chart:
                            description: Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
                            type: string
                          directory:
                            description: Directory holds path/directory specific options
                            properties:
                              exclude:
                                description: Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
                                type: string
                              include:
                                description: Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
                                type: string
                              jsonnet:
                                description: Jsonnet holds options specific to Jsonnet
                                properties:
                                  extVars:
                                    description: ExtVars is a list of Jsonnet External Variables
                                    items:
                                      description: JsonnetVar represents a variable to be passed to jsonnet during manifest generation
                                      properties:
                                        code:
                                          type: boolean
                                        name:
                                          type: string
                                        value:
                                          type: string
                                      required:
                                      - name
                                      - value
                                      type: object
                                    type: array
                                  libs:
                                    description: Additional library search dirs
                                    items:
                                      type: string
                                    type: array
                                  tlas:
                                    description: TLAS is a list of Jsonnet Top-level Arguments
                                    items:
                                      description: JsonnetVar represents a variable to be passed to jsonnet during manifest generation
                                      properties:
                                        code:
                                          type: boolean
                                        name:
                                          type: string
                                        value:
                                          type: string
                                      required:
                                      - name
                                      - value
                                      type: object
                                    type: array
                                type: object
                              recurse:
                                description: Recurse specifies whether to scan a directory recursively for manifests
                                type: boolean
                            type: object
                          helm:
                            description: Helm holds helm specific options
                            properties:
                              fileParameters:
                                description: FileParameters are file parameters to the helm template
                                items:
                                  description: HelmFileParameter is a file parameter that's passed to helm template during manifest generation
                                  properties:
                                    name:
                                      description: Name is the name of the Helm parameter
                                      type: string
                                    path:
                                      description: Path is the path to the file containing the values for the Helm parameter
                                      type: string
                                  type: object
                                type: array
                              parameters:
                                description: Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
                                items:
                                  description: HelmParameter is a parameter that's passed to helm template during manifest generation
                                  properties:
                                    forceString:
                                      description: ForceString determines whether to tell Helm to interpret booleans and numbers as strings
                                      type: boolean
                                    name:
                                      description: Name is the name of the Helm parameter
                                      type: string
                                    value:
                                      description: Value is the value for the Helm parameter
                                      type: string
                                  type: object
                                type: array
                              releaseName:
                                description: ReleaseName is the Helm release name to use. If omitted it will use the application name
                                type: string
                              valueFiles:
                                description: ValuesFiles is a list of Helm value files to use when generating a template
                                items:
                                  type: string
                                type: array
                              values:
                                description: Values specifies Helm values to be passed to helm template, typically defined as a block
                                type: string
                              version:
                                description: Version is the Helm version to use for templating (either "2" or "3")
                                type: string
                            type: object
                          ksonnet:
                            description: Ksonnet holds ksonnet specific options
                            properties:
                              environment:
                                description: Environment is a ksonnet application environment name
                                type: string
                              parameters:
                                description: Parameters are a list of ksonnet component parameter override values
                                items:
                                  description: KsonnetParameter is a ksonnet component parameter
                                  properties:
                                    component:
                                      type: string
                                    name:
                                      type: string
                                    value:
                                      type: string
                                  required:
                                  - name
                                  - value
                                  type: object
                                type: array
                            type: object
                          kustomize:
                            description: Kustomize holds kustomize specific options
                            properties:
                              commonAnnotations:
                                additionalProperties:
                                  type: string
                                description: CommonAnnotations is a list of additional annotations to add to rendered manifests
                                type: object
                              commonLabels:
                                additionalProperties:
                                  type: string
                                description: CommonLabels is a list of additional labels to add to rendered manifests
                                type: object
                              images:
                                description: Images is a list of Kustomize image override specifications
                                items:
                                  description: KustomizeImage represents a Kustomize image definition in the format [old_image_name=]<image_name>:<image_tag>
                                  type: string
                                type: array
                              namePrefix:
                                description: NamePrefix is a prefix appended to resources for Kustomize apps
                                type: string
                              nameSuffix:
                                description: NameSuffix is a suffix appended to resources for Kustomize apps
                                type: string
                              version:
                                description: Version controls which version of Kustomize to use for rendering manifests
                                type: string
                            type: object
                          path:
                            description: Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
                            type: string
                          plugin:
                            description: ConfigManagementPlugin holds config management plugin specific options
                            properties:
                              env:
                                description: Env is a list of environment variable entries
                                items:
                                  description: EnvEntry represents an entry in the application's environment
                                  properties:
                                    name:
                                      description: Name is the name of the variable, usually expressed in uppercase
                                      type: string
                                    value:
                                      description: Value is the value of the variable
                                      type: string
                                  required:
                                  - name
                                  - value
                                  type: object
                                type: array
                              name:
                                type: string
                            type: object
                          repoURL:
                            description: RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
                            type: string
                          targetRevision:
                            description: TargetRevision defines the revision of the source to sync the application to. In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD. In case of Helm, this is a semver tag for the Chart's version.
                            type: string
                        required:
                        - repoURL
                        type: object
                    required:
                    - revision
                    type: object
                required:
                - operation
                - phase
                - startedAt
                type: object
              reconciledAt:
                description: ReconciledAt indicates when the application state was reconciled using the latest git version
                format: date-time
                type: string
              resources:
                description: Resources is a list of Kubernetes resources managed by this application
                items:
                  description: 'ResourceStatus holds the current sync and health status of a resource TODO: describe members of this type'
                  properties:
                    group:
                      type: string
                    health:
                      description: HealthStatus contains information about the currently observed health state of an application or resource
                      properties:
                        message:
                          description: Message is a human-readable informational message describing the health status
                          type: string
                        status:
                          description: Status holds the status code of the application or resource
                          type: string
                      type: object
                    hook:
                      type: boolean
                    kind:
                      type: string
                    name:
                      type: string
                    namespace:
                      type: string
                    requiresPruning:
                      type: boolean
                    status:
                      description: SyncStatusCode is a type which represents possible comparison results
                      type: string
                    version:
                      type: string
                  type: object
                type: array
              sourceType:
                description: SourceType specifies the type of this application
                type: string
              summary:
                description: Summary contains a list of URLs and container images used by this application
                properties:
                  externalURLs:
                    description: ExternalURLs holds all external URLs of application child resources.
                    items:
                      type: string
                    type: array
                  images:
                    description: Images holds all images of application child resources.
                    items:
                      type: string
                    type: array
                type: object
              sync:
                description: Sync contains information about the application's current sync status
                properties:
                  comparedTo:
                    description: ComparedTo contains information about what has been compared
                    properties:
                      destination:
                        description: Destination is a reference to the application's destination used for comparison
                        properties:
                          name:
                            description: Name is an alternate way of specifying the target cluster by its symbolic name
                            type: string
                          namespace:
                            description: Namespace specifies the target namespace for the application's resources. The namespace will only be set for namespace-scoped resources that have not set a value for .metadata.namespace
                            type: string
                          server:
                            description: Server specifies the URL of the target cluster and must be set to the Kubernetes control plane API
                            type: string
                        type: object
                      source:
                        description: Source is a reference to the application's source used for comparison
                        properties:
                          chart:
                            description: Chart is a Helm chart name, and must be specified for applications sourced from a Helm repo.
                            type: string
                          directory:
                            description: Directory holds path/directory specific options
                            properties:
                              exclude:
                                description: Exclude contains a glob pattern to match paths against that should be explicitly excluded from being used during manifest generation
                                type: string
                              include:
                                description: Include contains a glob pattern to match paths against that should be explicitly included during manifest generation
                                type: string
                              jsonnet:
                                description: Jsonnet holds options specific to Jsonnet
                                properties:
                                  extVars:
                                    description: ExtVars is a list of Jsonnet External Variables
                                    items:
                                      description: JsonnetVar represents a variable to be passed to jsonnet during manifest generation
                                      properties:
                                        code:
                                          type: boolean
                                        name:
                                          type: string
                                        value:
                                          type: string
                                      required:
                                      - name
                                      - value
                                      type: object
                                    type: array
                                  libs:
                                    description: Additional library search dirs
                                    items:
                                      type: string
                                    type: array
                                  tlas:
                                    description: TLAS is a list of Jsonnet Top-level Arguments
                                    items:
                                      description: JsonnetVar represents a variable to be passed to jsonnet during manifest generation
                                      properties:
                                        code:
                                          type: boolean
                                        name:
                                          type: string
                                        value:
                                          type: string
                                      required:
                                      - name
                                      - value
                                      type: object
                                    type: array
                                type: object
                              recurse:
                                description: Recurse specifies whether to scan a directory recursively for manifests
                                type: boolean
                            type: object
                          helm:
                            description: Helm holds helm specific options
                            properties:
                              fileParameters:
                                description: FileParameters are file parameters to the helm template
                                items:
                                  description: HelmFileParameter is a file parameter that's passed to helm template during manifest generation
                                  properties:
                                    name:
                                      description: Name is the name of the Helm parameter
                                      type: string
                                    path:
                                      description: Path is the path to the file containing the values for the Helm parameter
                                      type: string
                                  type: object
                                type: array
                              parameters:
                                description: Parameters is a list of Helm parameters which are passed to the helm template command upon manifest generation
                                items:
                                  description: HelmParameter is a parameter that's passed to helm template during manifest generation
                                  properties:
                                    forceString:
                                      description: ForceString determines whether to tell Helm to interpret booleans and numbers as strings
                                      type: boolean
                                    name:
                                      description: Name is the name of the Helm parameter
                                      type: string
                                    value:
                                      description: Value is the value for the Helm parameter
                                      type: string
                                  type: object
                                type: array
                              releaseName:
                                description: ReleaseName is the Helm release name to use. If omitted it will use the application name
                                type: string
                              valueFiles:
                                description: ValuesFiles is a list of Helm value files to use when generating a template
                                items:
                                  type: string
                                type: array
                              values:
                                description: Values specifies Helm values to be passed to helm template, typically defined as a block
                                type: string
                              version:
                                description: Version is the Helm version to use for templating (either "2" or "3")
                                type: string
                            type: object
                          ksonnet:
                            description: Ksonnet holds ksonnet specific options
                            properties:
                              environment:
                                description: Environment is a ksonnet application environment name
                                type: string
                              parameters:
                                description: Parameters are a list of ksonnet component parameter override values
                                items:
                                  description: KsonnetParameter is a ksonnet component parameter
                                  properties:
                                    component:
                                      type: string
                                    name:
                                      type: string
                                    value:
                                      type: string
                                  required:
                                  - name
                                  - value
                                  type: object
                                type: array
                            type: object
                          kustomize:
                            description: Kustomize holds kustomize specific options
                            properties:
                              commonAnnotations:
                                additionalProperties:
                                  type: string
                                description: CommonAnnotations is a list of additional annotations to add to rendered manifests
                                type: object
                              commonLabels:
                                additionalProperties:
                                  type: string
                                description: CommonLabels is a list of additional labels to add to rendered manifests
                                type: object
                              images:
                                description: Images is a list of Kustomize image override specifications
                                items:
                                  description: KustomizeImage represents a Kustomize image definition in the format [old_image_name=]<image_name>:<image_tag>
                                  type: string
                                type: array
                              namePrefix:
                                description: NamePrefix is a prefix appended to resources for Kustomize apps
                                type: string
                              nameSuffix:
                                description: NameSuffix is a suffix appended to resources for Kustomize apps
                                type: string
                              version:
                                description: Version controls which version of Kustomize to use for rendering manifests
                                type: string
                            type: object
                          path:
                            description: Path is a directory path within the Git repository, and is only valid for applications sourced from Git.
                            type: string
                          plugin:
                            description: ConfigManagementPlugin holds config management plugin specific options
                            properties:
                              env:
                                description: Env is a list of environment variable entries
                                items:
                                  description: EnvEntry represents an entry in the application's environment
                                  properties:
                                    name:
                                      description: Name is the name of the variable, usually expressed in uppercase
                                      type: string
                                    value:
                                      description: Value is the value of the variable
                                      type: string
                                  required:
                                  - name
                                  - value
                                  type: object
                                type: array
                              name:
                                type: string
                            type: object
                          repoURL:
                            description: RepoURL is the URL to the repository (Git or Helm) that contains the application manifests
                            type: string
                          targetRevision:
                            description: TargetRevision defines the revision of the source to sync the application to. In case of Git, this can be commit, tag, or branch. If omitted, will equal to HEAD. In case of Helm, this is a semver tag for the Chart's version.
                            type: string
                        required:
                        - repoURL
                        type: object
                    required:
                    - destination
                    - source
                    type: object
                  revision:
                    description: Revision contains information about the revision the comparison has been performed to
                    type: string
                  status:
                    description: Status is the sync state of the comparison
                    type: string
                required:
                - status
                type: object
            type: object
        required:
        - metadata
        - spec
        type: object
    served: true
    storage: true
    subresources: {}
---
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  labels:
    app.kubernetes.io/name: appprojects.argoproj.io
    app.kubernetes.io/part-of: argocd
  name: appprojects.argoproj.io
spec:
  group: argoproj.io
  names:
    kind: AppProject
    listKind: AppProjectList
    plural: appprojects
    shortNames:
    - appproj
    - appprojs
    singular: appproject
  scope: Namespaced
  versions:
  - name: v1alpha1
    schema:
      openAPIV3Schema:
        description: 'AppProject provides a logical grouping of applications, providing controls for: * where the apps may deploy to (cluster whitelist) * what may be deployed (repository whitelist, resource whitelist/blacklist) * who can access these applications (roles, OIDC group claims bindings) * and what they can do (RBAC policies) * automation access to these roles (JWT tokens)'
        properties:
          apiVersion:
            description: 'APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources'
            type: string
          kind:
            description: 'Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds'
            type: string
          metadata:
            type: object
          spec:
            description: AppProjectSpec is the specification of an AppProject
            properties:
              clusterResourceBlacklist:
                description: ClusterResourceBlacklist contains list of blacklisted cluster level resources
                items:
                  description: GroupKind specifies a Group and a Kind, but does not force a version.  This is useful for identifying concepts during lookup stages without having partially valid types
                  properties:
                    group:
                      type: string
                    kind:
                      type: string
                  required:
                  - group
                  - kind
                  type: object
                type: array
              clusterResourceWhitelist:
                description: ClusterResourceWhitelist contains list of whitelisted cluster level resources
                items:
                  description: GroupKind specifies a Group and a Kind, but does not force a version.  This is useful for identifying concepts during lookup stages without having partially valid types
                  properties:
                    group:
                      type: string
                    kind:
                      type: string
                  required:
                  - group
                  - kind
                  type: object
                type: array
              description:
                description: Description contains optional project description
                type: string
              destinations:
                description: Destinations contains list of destinations available for deployment
                items:
                  description: ApplicationDestination holds information about the application's destination
                  properties:
                    name:
                      description: Name is an alternate way of specifying the target cluster by its symbolic name
                      type: string
                    namespace:
                      description: Namespace specifies the target namespace for the application's resources. The namespace will only be set for namespace-scoped resources that have not set a value for .metadata.namespace
                      type: string
                    server:
                      description: Server specifies the URL of the target cluster and must be set to the Kubernetes control plane API
                      type: string
                  type: object
                type: array
              namespaceResourceBlacklist:
                description: NamespaceResourceBlacklist contains list of blacklisted namespace level resources
                items:
                  description: GroupKind specifies a Group and a Kind, but does not force a version.  This is useful for identifying concepts during lookup stages without having partially valid types
                  properties:
                    group:
                      type: string
                    kind:
                      type: string
                  required:
                  - group
                  - kind
                  type: object
                type: array
              namespaceResourceWhitelist:
                description: NamespaceResourceWhitelist contains list of whitelisted namespace level resources
                items:
                  description: GroupKind specifies a Group and a Kind, but does not force a version.  This is useful for identifying concepts during lookup stages without having partially valid types
                  properties:
                    group:
                      type: string
                    kind:
                      type: string
                  required:
                  - group
                  - kind
                  type: object
                type: array
              orphanedResources:
                description: OrphanedResources specifies if controller should monitor orphaned resources of apps in this project
                properties:
                  ignore:
                    description: Ignore contains a list of resources that are to be excluded from orphaned resources monitoring
                    items:
                      description: OrphanedResourceKey is a reference to a resource to be ignored from
                      properties:
                        group:
                          type: string
                        kind:
                          type: string
                        name:
                          type: string
                      type: object
                    type: array
                  warn:
                    description: Warn indicates if warning condition should be created for apps which have orphaned resources
                    type: boolean
                type: object
              roles:
                description: Roles are user defined RBAC roles associated with this project
                items:
                  description: ProjectRole represents a role that has access to a project
                  properties:
                    description:
                      description: Description is a description of the role
                      type: string
                    groups:
                      description: Groups are a list of OIDC group claims bound to this role
                      items:
                        type: string
                      type: array
                    jwtTokens:
                      description: JWTTokens are a list of generated JWT tokens bound to this role
                      items:
                        description: JWTToken holds the issuedAt and expiresAt values of a token
                        properties:
                          exp:
                            format: int64
                            type: integer
                          iat:
                            format: int64
                            type: integer
                          id:
                            type: string
                        required:
                        - iat
                        type: object
                      type: array
                    name:
                      description: Name is a name for this role
                      type: string
                    policies:
                      description: Policies Stores a list of casbin formated strings that define access policies for the role in the project
                      items:
                        type: string
                      type: array
                  required:
                  - name
                  type: object
                type: array
              signatureKeys:
                description: SignatureKeys contains a list of PGP key IDs that commits in Git must be signed with in order to be allowed for sync
                items:
                  description: SignatureKey is the specification of a key required to verify commit signatures with
                  properties:
                    keyID:
                      description: The ID of the key in hexadecimal notation
                      type: string
                  required:
                  - keyID
                  type: object
                type: array
              sourceRepos:
                description: SourceRepos contains list of repository URLs which can be used for deployment
                items:
                  type: string
                type: array
              syncWindows:
                description: SyncWindows controls when syncs can be run for apps in this project
                items:
                  description: SyncWindow contains the kind, time, duration and attributes that are used to assign the syncWindows to apps
                  properties:
                    applications:
                      description: Applications contains a list of applications that the window will apply to
                      items:
                        type: string
                      type: array
                    clusters:
                      description: Clusters contains a list of clusters that the window will apply to
                      items:
                        type: string
                      type: array
                    duration:
                      description: Duration is the amount of time the sync window will be open
                      type: string
                    kind:
                      description: Kind defines if the window allows or blocks syncs
                      type: string
                    manualSync:
                      description: ManualSync enables manual syncs when they would otherwise be blocked
                      type: boolean
                    namespaces:
                      description: Namespaces contains a list of namespaces that the window will apply to
                      items:
                        type: string
                      type: array
                    schedule:
                      description: Schedule is the time the window will begin, specified in cron format
                      type: string
                  type: object
                type: array
            type: object
          status:
            description: AppProjectStatus contains status information for AppProject CRs
            properties:
              jwtTokensByRole:
                additionalProperties:
                  description: JWTTokens represents a list of JWT tokens
                  properties:
                    items:
                      items:
                        description: JWTToken holds the issuedAt and expiresAt values of a token
                        properties:
                          exp:
                            format: int64
                            type: integer
                          iat:
                            format: int64
                            type: integer
                          id:
                            type: string
                        required:
                        - iat
                        type: object
                      type: array
                  type: object
                description: JWTTokensByRole contains a list of JWT tokens issued for a given role
                type: object
            type: object
        required:
        - metadata
        - spec
        type: object
    served: true
    storage: true
---
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app.kubernetes.io/component: application-controller
    app.kubernetes.io/name: argocd-application-controller
    app.kubernetes.io/part-of: argocd
  name: argocd-application-controller
---
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app.kubernetes.io/component: dex-server
    app.kubernetes.io/name: argocd-dex-server
    app.kubernetes.io/part-of: argocd
  name: argocd-dex-server
---
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app.kubernetes.io/component: redis
    app.kubernetes.io/name: argocd-redis
    app.kubernetes.io/part-of: argocd
  name: argocd-redis
---
apiVersion: v1
kind: ServiceAccount
metadata:
  labels:
    app.kubernetes.io/component: server
    app.kubernetes.io/name: argocd-server
    app.kubernetes.io/part-of: argocd
  name: argocd-server
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  labels:
    app.kubernetes.io/component: application-controller
    app.kubernetes.io/name: argocd-application-controller
    app.kubernetes.io/part-of: argocd
  name: argocd-application-controller
rules:
- apiGroups:
  - ""
  resources:
  - secrets
  - configmaps
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - argoproj.io
  resources:
  - applications
  - appprojects
  verbs:
  - create
  - get
  - list
  - watch
  - update
  - patch
  - delete
- apiGroups:
  - ""
  resources:
  - events
  verbs:
  - create
  - list
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  labels:
    app.kubernetes.io/component: dex-server
    app.kubernetes.io/name: argocd-dex-server
    app.kubernetes.io/part-of: argocd
  name: argocd-dex-server
rules:
- apiGroups:
  - ""
  resources:
  - secrets
  - configmaps
  verbs:
  - get
  - list
  - watch
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  labels:
    app.kubernetes.io/component: redis
    app.kubernetes.io/name: argocd-redis
    app.kubernetes.io/part-of: argocd
  name: argocd-redis
rules:
- apiGroups:
  - security.openshift.io
  resourceNames:
  - nonroot
  resources:
  - securitycontextconstraints
  verbs:
  - use
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  labels:
    app.kubernetes.io/component: server
    app.kubernetes.io/name: argocd-server
    app.kubernetes.io/part-of: argocd
  name: argocd-server
rules:
- apiGroups:
  - ""
  resources:
  - secrets
  - configmaps
  verbs:
  - create
  - get
  - list
  - watch
  - update
  - patch
  - delete
- apiGroups:
  - argoproj.io
  resources:
  - applications
  - appprojects
  verbs:
  - create
  - get
  - list
  - watch
  - update
  - delete
  - patch
- apiGroups:
  - ""
  resources:
  - events
  verbs:
  - create
  - list
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app.kubernetes.io/component: application-controller
    app.kubernetes.io/name: argocd-application-controller
    app.kubernetes.io/part-of: argocd
  name: argocd-application-controller
rules:
- apiGroups:
  - '*'
  resources:
  - '*'
  verbs:
  - '*'
- nonResourceURLs:
  - '*'
  verbs:
  - '*'
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    app.kubernetes.io/component: server
    app.kubernetes.io/name: argocd-server
    app.kubernetes.io/part-of: argocd
  name: argocd-server
rules:
- apiGroups:
  - '*'
  resources:
  - '*'
  verbs:
  - delete
  - get
  - patch
- apiGroups:
  - ""
  resources:
  - events
  verbs:
  - list
- apiGroups:
  - ""
  resources:
  - pods
  - pods/log
  verbs:
  - get
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  labels:
    app.kubernetes.io/component: application-controller
    app.kubernetes.io/name: argocd-application-controller
    app.kubernetes.io/part-of: argocd
  name: argocd-application-controller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: argocd-application-controller
subjects:
- kind: ServiceAccount
  name: argocd-application-controller
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  labels:
    app.kubernetes.io/component: dex-server
    app.kubernetes.io/name: argocd-dex-server
    app.kubernetes.io/part-of: argocd
  name: argocd-dex-server
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: argocd-dex-server
subjects:
- kind: ServiceAccount
  name: argocd-dex-server
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  labels:
    app.kubernetes.io/component: redis
    app.kubernetes.io/name: argocd-redis
    app.kubernetes.io/part-of: argocd
  name: argocd-redis
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: argocd-redis
subjects:
- kind: ServiceAccount
  name: argocd-redis
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  labels:
    app.kubernetes.io/component: server
    app.kubernetes.io/name: argocd-server
    app.kubernetes.io/part-of: argocd
  name: argocd-server
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: argocd-server
subjects:
- kind: ServiceAccount
  name: argocd-server
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    app.kubernetes.io/component: application-controller
    app.kubernetes.io/name: argocd-application-controller
    app.kubernetes.io/part-of: argocd
  name: argocd-application-controller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: argocd-application-controller
subjects:
- kind: ServiceAccount
  name: argocd-application-controller
  namespace: argocd
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  labels:
    app.kubernetes.io/component: server
    app.kubernetes.io/name: argocd-server
    app.kubernetes.io/part-of: argocd
  name: argocd-server
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: argocd-server
subjects:
- kind: ServiceAccount
  name: argocd-server
  namespace: argocd
---
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    app.kubernetes.io/name: argocd-cm
    app.kubernetes.io/part-of: argocd
  name: argocd-cm
---
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    app.kubernetes.io/name: argocd-gpg-keys-cm
    app.kubernetes.io/part-of: argocd
  name: argocd-gpg-keys-cm
---
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    app.kubernetes.io/name: argocd-rbac-cm
    app.kubernetes.io/part-of: argocd
  name: argocd-rbac-cm
---
apiVersion: v1
data:
  ssh_known_hosts: |
    bitbucket.org ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAubiN81eDcafrgMeLzaFPsw2kNvEcqTKl/VqLat/MaB33pZy0y3rJZtnqwR2qOOvbwKZYKiEO1O6VqNEBxKvJJelCq0dTXWT5pbO2gDXC6h6QDXCaHo6pOHGPUy+YBaGQRGuSusMEASYiWunYN0vCAI8QaXnWMXNMdFP3jHAJH0eDsoiGnLPBlBp4TNm6rYI74nMzgz3B9IikW4WVK+dc8KZJZWYjAuORU3jc1c/NPskD2ASinf8v3xnfXeukU0sJ5N6m5E8VLjObPEO+mN2t/FZTMZLiFqPWc/ALSqnMnnhwrNi2rbfg/rd/IpL8Le3pSBne8+seeFVBoGqzHM9yXw==
    github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==
    gitlab.com ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBFSMqzJeV9rUzU4kWitGjeR4PWSa29SPqJ1fVkhtj3Hw9xjLVXVYrU9QlYWrOLXBpQ6KWjbjTDTdDkoohFzgbEY=
    gitlab.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAfuCHKVTjquxvt6CM6tdG4SLp1Btn/nOeHHE5UOzRdf
    gitlab.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsj2bNKTBSpIYDEGk9KxsGh3mySTRgMtXL583qmBpzeQ+jqCMRgBqB98u3z++J1sKlXHWfM9dyhSevkMwSbhoR8XIq/U0tCNyokEi/ueaBMCvbcTHhO7FcwzY92WK4Yt0aGROY5qX2UKSeOvuP4D6TPqKF1onrSzH9bx9XUf2lEdWT/ia1NEKjunUqu1xOB/StKDHMoX4/OKyIzuS0q/T1zOATthvasJFoPrAjkohTyaDUz2LN5JoH839hViyEG82yB+MjcFV5MU3N1l1QL3cVUCh93xSaua1N85qivl+siMkPGbO5xR/En4iEY6K2XPASUEMaieWVNTRCtJ4S8H+9
    ssh.dev.azure.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7Hr1oTWqNqOlzGJOfGJ4NakVyIzf1rXYd4d7wo6jBlkLvCA4odBlL0mDUyZ0/QUfTTqeu+tm22gOsv+VrVTMk6vwRU75gY/y9ut5Mb3bR5BV58dKXyq9A9UeB5Cakehn5Zgm6x1mKoVyf+FFn26iYqXJRgzIZZcZ5V6hrE0Qg39kZm4az48o0AUbf6Sp4SLdvnuMa2sVNwHBboS7EJkm57XQPVU3/QpyNLHbWDdzwtrlS+ez30S3AdYhLKEOxAG8weOnyrtLJAUen9mTkol8oII1edf7mWWbWVf0nBmly21+nZcmCTISQBtdcyPaEno7fFQMDD26/s0lfKob4Kw8H
    vs-ssh.visualstudio.com ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7Hr1oTWqNqOlzGJOfGJ4NakVyIzf1rXYd4d7wo6jBlkLvCA4odBlL0mDUyZ0/QUfTTqeu+tm22gOsv+VrVTMk6vwRU75gY/y9ut5Mb3bR5BV58dKXyq9A9UeB5Cakehn5Zgm6x1mKoVyf+FFn26iYqXJRgzIZZcZ5V6hrE0Qg39kZm4az48o0AUbf6Sp4SLdvnuMa2sVNwHBboS7EJkm57XQPVU3/QpyNLHbWDdzwtrlS+ez30S3AdYhLKEOxAG8weOnyrtLJAUen9mTkol8oII1edf7mWWbWVf0nBmly21+nZcmCTISQBtdcyPaEno7fFQMDD26/s0lfKob4Kw8H
kind: ConfigMap
metadata:
  labels:
    app.kubernetes.io/name: argocd-ssh-known-hosts-cm
    app.kubernetes.io/part-of: argocd
  name: argocd-ssh-known-hosts-cm
---
apiVersion: v1
data: null
kind: ConfigMap
metadata:
  labels:
    app.kubernetes.io/name: argocd-tls-certs-cm
    app.kubernetes.io/part-of: argocd
  name: argocd-tls-certs-cm
---
apiVersion: v1
kind: Secret
metadata:
  labels:
    app.kubernetes.io/name: argocd-secret
    app.kubernetes.io/part-of: argocd
  name: argocd-secret
type: Opaque
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/component: dex-server
    app.kubernetes.io/name: argocd-dex-server
    app.kubernetes.io/part-of: argocd
  name: argocd-dex-server
spec:
  ports:
  - name: http
    port: 5556
    protocol: TCP
    targetPort: 5556
  - name: grpc
    port: 5557
    protocol: TCP
    targetPort: 5557
  - name: metrics
    port: 5558
    protocol: TCP
    targetPort: 5558
  selector:
    app.kubernetes.io/name: argocd-dex-server
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/component: metrics
    app.kubernetes.io/name: argocd-metrics
    app.kubernetes.io/part-of: argocd
  name: argocd-metrics
spec:
  ports:
  - name: metrics
    port: 8082
    protocol: TCP
    targetPort: 8082
  selector:
    app.kubernetes.io/name: argocd-application-controller
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/component: redis
    app.kubernetes.io/name: argocd-redis
    app.kubernetes.io/part-of: argocd
  name: argocd-redis
spec:
  ports:
  - name: tcp-redis
    port: 6379
    targetPort: 6379
  selector:
    app.kubernetes.io/name: argocd-redis
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/component: repo-server
    app.kubernetes.io/name: argocd-repo-server
    app.kubernetes.io/part-of: argocd
  name: argocd-repo-server
spec:
  ports:
  - name: server
    port: 8081
    protocol: TCP
    targetPort: 8081
  - name: metrics
    port: 8084
    protocol: TCP
    targetPort: 8084
  selector:
    app.kubernetes.io/name: argocd-repo-server
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/component: server
    app.kubernetes.io/name: argocd-server
    app.kubernetes.io/part-of: argocd
  name: argocd-server
spec:
  type: NodePort
  ports:
  - name: http
    port: 80
    protocol: TCP
    targetPort: 8080
    nodePort: 31001
  - name: https
    port: 443
    protocol: TCP
    targetPort: 8080
  selector:
    app.kubernetes.io/name: argocd-server
---
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/component: server
    app.kubernetes.io/name: argocd-server-metrics
    app.kubernetes.io/part-of: argocd
  name: argocd-server-metrics
spec:
  ports:
  - name: metrics
    port: 8083
    protocol: TCP
    targetPort: 8083
  selector:
    app.kubernetes.io/name: argocd-server
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: dex-server
    app.kubernetes.io/name: argocd-dex-server
    app.kubernetes.io/part-of: argocd
  name: argocd-dex-server
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: argocd-dex-server
  template:
    metadata:
      labels:
        app.kubernetes.io/name: argocd-dex-server
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - podAffinityTerm:
              labelSelector:
                matchLabels:
                  app.kubernetes.io/part-of: argocd
              topologyKey: kubernetes.io/hostname
            weight: 5
      containers:
      - command:
        - /shared/argocd-dex
        - rundex
        image: ghcr.io/dexidp/dex:v2.27.0
        imagePullPolicy: Always
        name: dex
        ports:
        - containerPort: 5556
        - containerPort: 5557
        - containerPort: 5558
        volumeMounts:
        - mountPath: /shared
          name: static-files
      initContainers:
      - command:
        - cp
        - -n
        - /usr/local/bin/argocd
        - /shared/argocd-dex
        image: quay.io/argoproj/argocd:v2.0.2
        imagePullPolicy: Always
        name: copyutil
        volumeMounts:
        - mountPath: /shared
          name: static-files
      serviceAccountName: argocd-dex-server
      volumes:
      - emptyDir: {}
        name: static-files
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: redis
    app.kubernetes.io/name: argocd-redis
    app.kubernetes.io/part-of: argocd
  name: argocd-redis
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: argocd-redis
  template:
    metadata:
      labels:
        app.kubernetes.io/name: argocd-redis
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - podAffinityTerm:
              labelSelector:
                matchLabels:
                  app.kubernetes.io/name: argocd-redis
              topologyKey: kubernetes.io/hostname
            weight: 100
          - podAffinityTerm:
              labelSelector:
                matchLabels:
                  app.kubernetes.io/part-of: argocd
              topologyKey: kubernetes.io/hostname
            weight: 5
      containers:
      - args:
        - --save
        - ""
        - --appendonly
        - "no"
        image: redis:6.2.1-alpine
        imagePullPolicy: Always
        name: redis
        ports:
        - containerPort: 6379
      securityContext:
        fsGroup: 1000
        runAsGroup: 1000
        runAsNonRoot: true
        runAsUser: 1000
      serviceAccountName: argocd-redis
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: repo-server
    app.kubernetes.io/name: argocd-repo-server
    app.kubernetes.io/part-of: argocd
  name: argocd-repo-server
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: argocd-repo-server
  template:
    metadata:
      labels:
        app.kubernetes.io/name: argocd-repo-server
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - podAffinityTerm:
              labelSelector:
                matchLabels:
                  app.kubernetes.io/name: argocd-repo-server
              topologyKey: kubernetes.io/hostname
            weight: 100
          - podAffinityTerm:
              labelSelector:
                matchLabels:
                  app.kubernetes.io/part-of: argocd
              topologyKey: kubernetes.io/hostname
            weight: 5
      automountServiceAccountToken: false
      containers:
      - command:
        - uid_entrypoint.sh
        - argocd-repo-server
        - --redis
        - argocd-redis:6379
        image: quay.io/argoproj/argocd:v2.0.2
        imagePullPolicy: Always
        livenessProbe:
          failureThreshold: 3
          httpGet:
            path: /healthz?full=true
            port: 8084
          initialDelaySeconds: 30
          periodSeconds: 5
        name: argocd-repo-server
        ports:
        - containerPort: 8081
        - containerPort: 8084
        readinessProbe:
          httpGet:
            path: /healthz
            port: 8084
          initialDelaySeconds: 5
          periodSeconds: 10
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - all
        volumeMounts:
        - mountPath: /app/config/ssh
          name: ssh-known-hosts
        - mountPath: /app/config/tls
          name: tls-certs
        - mountPath: /app/config/gpg/source
          name: gpg-keys
        - mountPath: /app/config/gpg/keys
          name: gpg-keyring
        - mountPath: /app/config/reposerver/tls
          name: argocd-repo-server-tls
      volumes:
      - configMap:
          name: argocd-ssh-known-hosts-cm
        name: ssh-known-hosts
      - configMap:
          name: argocd-tls-certs-cm
        name: tls-certs
      - configMap:
          name: argocd-gpg-keys-cm
        name: gpg-keys
      - emptyDir: {}
        name: gpg-keyring
      - name: argocd-repo-server-tls
        secret:
          items:
          - key: tls.crt
            path: tls.crt
          - key: tls.key
            path: tls.key
          - key: ca.crt
            path: ca.crt
          optional: true
          secretName: argocd-repo-server-tls
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: server
    app.kubernetes.io/name: argocd-server
    app.kubernetes.io/part-of: argocd
  name: argocd-server
spec:
  selector:
    matchLabels:
      app.kubernetes.io/name: argocd-server
  template:
    metadata:
      labels:
        app.kubernetes.io/name: argocd-server
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - podAffinityTerm:
              labelSelector:
                matchLabels:
                  app.kubernetes.io/name: argocd-server
              topologyKey: kubernetes.io/hostname
            weight: 100
          - podAffinityTerm:
              labelSelector:
                matchLabels:
                  app.kubernetes.io/part-of: argocd
              topologyKey: kubernetes.io/hostname
            weight: 5
      containers:
      - command:
        - argocd-server
        - --staticassets
        - /shared/app
        - --insecure
        image: quay.io/argoproj/argocd:v2.0.2
        imagePullPolicy: Always
        livenessProbe:
          httpGet:
            path: /healthz?full=true
            port: 8080
          initialDelaySeconds: 3
          periodSeconds: 30
        name: argocd-server
        ports:
        - containerPort: 8080
        - containerPort: 8083
        readinessProbe:
          httpGet:
            path: /healthz
            port: 8080
          initialDelaySeconds: 3
          periodSeconds: 30
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - all
        volumeMounts:
        - mountPath: /app/config/ssh
          name: ssh-known-hosts
        - mountPath: /app/config/tls
          name: tls-certs
        - mountPath: /app/config/server/tls
          name: argocd-repo-server-tls
      serviceAccountName: argocd-server
      volumes:
      - emptyDir: {}
        name: static-files
      - configMap:
          name: argocd-ssh-known-hosts-cm
        name: ssh-known-hosts
      - configMap:
          name: argocd-tls-certs-cm
        name: tls-certs
      - name: argocd-repo-server-tls
        secret:
          items:
          - key: tls.crt
            path: tls.crt
          - key: tls.key
            path: tls.key
          - key: ca.crt
            path: ca.crt
          optional: true
          secretName: argocd-repo-server-tls
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  labels:
    app.kubernetes.io/component: application-controller
    app.kubernetes.io/name: argocd-application-controller
    app.kubernetes.io/part-of: argocd
  name: argocd-application-controller
spec:
  replicas: 1
  selector:
    matchLabels:
      app.kubernetes.io/name: argocd-application-controller
  serviceName: argocd-application-controller
  template:
    metadata:
      labels:
        app.kubernetes.io/name: argocd-application-controller
    spec:
      affinity:
        podAntiAffinity:
          preferredDuringSchedulingIgnoredDuringExecution:
          - podAffinityTerm:
              labelSelector:
                matchLabels:
                  app.kubernetes.io/name: argocd-application-controller
              topologyKey: kubernetes.io/hostname
            weight: 100
          - podAffinityTerm:
              labelSelector:
                matchLabels:
                  app.kubernetes.io/part-of: argocd
              topologyKey: kubernetes.io/hostname
            weight: 5
      containers:
      - command:
        - argocd-application-controller
        - --status-processors
        - "20"
        - --operation-processors
        - "10"
        image: quay.io/argoproj/argocd:v2.0.2
        imagePullPolicy: Always
        livenessProbe:
          httpGet:
            path: /healthz
            port: 8082
          initialDelaySeconds: 5
          periodSeconds: 10
        name: argocd-application-controller
        ports:
        - containerPort: 8082
        readinessProbe:
          httpGet:
            path: /healthz
            port: 8082
          initialDelaySeconds: 5
          periodSeconds: 10
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - all
        volumeMounts:
        - mountPath: /app/config/controller/tls
          name: argocd-repo-server-tls
      serviceAccountName: argocd-application-controller
      volumes:
      - name: argocd-repo-server-tls
        secret:
          items:
          - key: tls.crt
            path: tls.crt
          - key: tls.key
            path: tls.key
          - key: ca.crt
            path: ca.crt
          optional: true
          secretName: argocd-repo-server-tls
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: argocd-application-controller-network-policy
spec:
  ingress:
  - from:
    - namespaceSelector: {}
    ports:
    - port: 8082
  podSelector:
    matchLabels:
      app.kubernetes.io/name: argocd-application-controller
  policyTypes:
  - Ingress
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: argocd-dex-server-network-policy
spec:
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app.kubernetes.io/name: argocd-server
    ports:
    - port: 5556
      protocol: TCP
    - port: 5557
      protocol: TCP
    - port: 5558
      protocol: TCP
  podSelector:
    matchLabels:
      app.kubernetes.io/name: argocd-dex-server
  policyTypes:
  - Ingress
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: argocd-redis-network-policy
spec:
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app.kubernetes.io/name: argocd-server
    - podSelector:
        matchLabels:
          app.kubernetes.io/name: argocd-repo-server
    - podSelector:
        matchLabels:
          app.kubernetes.io/name: argocd-application-controller
    ports:
    - port: 6379
      protocol: TCP
  podSelector:
    matchLabels:
      app.kubernetes.io/name: argocd-redis
  policyTypes:
  - Ingress
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: argocd-repo-server-network-policy
spec:
  ingress:
  - from:
    - podSelector:
        matchLabels:
          app.kubernetes.io/name: argocd-server
    - podSelector:
        matchLabels:
          app.kubernetes.io/name: argocd-application-controller
    ports:
    - port: 8081
      protocol: TCP
  - from:
    - namespaceSelector: {}
    ports:
    - port: 8084
  podSelector:
    matchLabels:
      app.kubernetes.io/name: argocd-repo-server
  policyTypes:
  - Ingress
---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: argocd-server-network-policy
spec:
  ingress:
  - {}
  podSelector:
    matchLabels:
      app.kubernetes.io/name: argocd-server
  policyTypes:
  - Ingress
EOF


kubectl create namespace argocd
kubectl apply -n argocd -f argocd.yaml
sleep 3
echo "installed argocd"

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
sleep 3
echo "installed helm"

kubectl create ns jenkins


helm repo add jenkins https://charts.jenkins.io

helm install jenkins \
--set controller.serviceType=NodePort,controller.nodePort=31000,persistence.enabled=false \
--namespace=jenkins \
jenkins/jenkins
