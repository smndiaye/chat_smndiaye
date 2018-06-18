const SLACK_TOKEN       = process.env.SLACK_TOKEN;
const PROJECT_USERNAME  = process.env.PROJECT_USERNAME;
const PROJECT_REPO_NAME = process.env.PROJECT_REPO_NAME;
const GITHUB_EMAIL      = process.env.GITHUB_EMAIL;
const GITHUB_TOKEN      = process.env.GITHUB_TOKEN;
const GITHUB_USERNAME   = process.env.GITHUB_USERNAME;


if (!SLACK_TOKEN) {
  process.stderr.write('Exit because SLACK_TOKEN not found in environment variables !');
  process.exit(1)
}

const BotKit     = require('botkit');
const controller = BotKit.slackbot({ debug: true });

controller.spawn({ token: SLACK_TOKEN }).startRTM();

controller.hears(
  '(.*)',
  ['ambient','mention'],
  (bot, message) => { bot.reply(message, message.text); }
  );

const exec = require('child_process').exec;
const url  = `https://${GITHUB_TOKEN}@github.com/${PROJECT_USERNAME}/${PROJECT_REPO_NAME}`;
const init = `git clone --branch master ${url} &&
              cd ${PROJECT_REPO_NAME} &&
              git fetch origin develop:develop &&
              git config user.name  '${GITHUB_USERNAME}' &&
              git config user.email '${GITHUB_EMAIL}' &&
              git flow init -d`;

exec(init, (err, stdout, stderr) => {
  process.stdout.write(stdout);
  process.stderr.write(stderr);
});

controller.hears(
  /staging start (\d+\.\d+\.\d+)/, 'direct_mention',
  (bot, message) => {
    bot.api.reactions.add({
      name:      'robot_face',
      channel:   message.channel,
      timestamp: message.ts,
    });

  const cmd = `cd ${PROJECT_REPO_NAME} &&
               git pull origin develop:develop &&
               git flow release start ${message.match[1]} --fetch &&
               git flow release publish ${message.match[1]} &&
               hub pull-request -b master -r smndiaye -a ${GITHUB_USERNAME} \
                                -l 'type: enhancement','status: under review' \
                                -m '🎉 Bump version to ${message.match[1]}' &&
               git flow release delete ${message.match[1]} -f`;

  exec(cmd, (err, stdout, stderr) => {
    process.stdout.write(stdout);
    process.stderr.write(stderr);
  })
});

controller.hears(/release finish (\d+\.\d+\.\d+)/, 'direct_mention',
  (bot, message) => {
    bot.api.reactions.add({
      name:      'robot_face',
      channel:   message.channel,
      timestamp: message.ts,
  });

  const cmd = `cd ${PROJECT_REPO_NAME} &&
               git flow release track ${message.match[1]} &&
               git flow release finish ${message.match[1]} --fetch --push --message '🎉 Bump version to'`;

  exec(cmd, (err, stdout, stderr) => {
    process.stdout.write(stdout);
    process.stderr.write(stderr)
  })
});