import { TestBed } from '@angular/core/testing';

import { ApiinterceptInterceptor } from './apiintercept.interceptor';

describe('ApiinterceptInterceptor', () => {
  beforeEach(() => TestBed.configureTestingModule({
    providers: [
      ApiinterceptInterceptor
      ]
  }));

  it('should be created', () => {
    const interceptor: ApiinterceptInterceptor = TestBed.inject(ApiinterceptInterceptor);
    expect(interceptor).toBeTruthy();
  });
});
