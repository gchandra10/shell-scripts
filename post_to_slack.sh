# This set will break the script if variables are not initialized properly.
set -o nounset

# This set will exit the script if any statement returns NON-True (a.k.a false)
set -o errexit

function post_to_slack () {
    # format message as a code block ```${msg}```
    SLACK_MESSAGE="\`\`\`$1\`\`\`"

    ## Get WebHook URL from Slack WebHook APP
    SLACK_URL=https://hooks.slack.com/services/T07FJKH/B2Z62/yYRbHaHIc

    case "$2" in
    INFO)
        SLACK_ICON=':slack:'
        ;;
    WARNING)
        SLACK_ICON=':warning:'
        ;;
    ERROR)
        SLACK_ICON=':bangbang:'
        ;;
    *)
        SLACK_ICON=':slack:'
        ;;
    esac

    curl -X POST --data "payload={\"text\": \"${SLACK_ICON} ${SLACK_MESSAGE}\"}" ${SLACK_URL}
}

## Usage

post_to_slack "Test message ..." "INFO"
exit 0