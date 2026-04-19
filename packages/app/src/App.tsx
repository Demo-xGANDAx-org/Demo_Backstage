import { createApp } from '@backstage/frontend-defaults';
import catalogPlugin from '@backstage/plugin-catalog/alpha';
import { navModule } from './modules/nav';

import { googleAuthApiRef } from '@backstage/core-plugin-api';
import { SignInPageBlueprint } from '@backstage/plugin-app-react';
import { SignInPage } from '@backstage/core-components';
import { createFrontendModule } from '@backstage/frontend-plugin-api';

const signInPage = SignInPageBlueprint.make({
  params: {
    loader: async () => props =>
    (
      <SignInPage
        {...props}
        provider={{
          id: 'github-auth-provider',
          title: 'Google',
          message: 'Sign in using Google',
          apiRef: googleAuthApiRef,
        }}
      />
    ),
  },
});

export default createApp({
  features: [catalogPlugin, navModule, createFrontendModule({
    pluginId: 'app',
    extensions: [signInPage],
  }),],
});
