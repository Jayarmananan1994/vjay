import { TestBed } from '@angular/core/testing';

import { BruceService } from './bruce.service';

describe('BruceService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: BruceService = TestBed.get(BruceService);
    expect(service).toBeTruthy();
  });
});
